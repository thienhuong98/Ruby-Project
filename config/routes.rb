Rails.application.routes.draw do
  root 'home#index'
  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'
  get 'learn/:category_id', to: 'words#index', as: 'learn'
  post 'word/add_learnt_word', to: 'words#add_learnt_word'
  get 'learnt_words', to: 'words#learnt_words'
  
  namespace :admin do
    resources :answers
    resources :questions
    resources :categories
    resources :words
    resources :tests
    resources :users
  end
  #get    '/login',   to: 'sessions#new'
  #post   '/login',   to: 'sessions#create'
  # delete '/logout',  to: 'sessions#destroy'
  #devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout'}
  ##get 'users/:id', to: 'users#show', as: 'usersssss'
  devise_for :users
  as :user do
    get 'login', to: 'devise/sessions#new'
    post 'login', to: 'devise/sessions#create'
    delete 'logout', to: 'devise/sessions#destroy', via: Devise.mappings[:user].sign_out_via
  end

  resources :tests, only: [:show, :create, :update] do
    member do
      get 'do', to: 'tests#edit'
    end
  end

  resources :users, only: :show do
    member do
      get 'following', to: 'users#following'
      get 'followers', to: 'users#followers'
    end
  end

  resources :answers
  resources :questions
  resources :categories
  resources :words
  resources :relationships, only: [:create, :destroy]

  namespace :api, defaults: {format: :json} do
    as :user do
      #get 'login', to: 'users#new'
      post 'signup', to: 'registrations#create'
      post 'login', to: 'sessions#create'
      delete 'logout', to: 'sessions#destroy', via: Devise.mappings[:user].sign_out_via
    end
    scope '/user' do
      get 'info', to: 'users#info'
      get 'newsfeed', to: 'users#newsfeed'
      get 'followers', to:'users#followers'
      get 'following', to:'users#following'
    end
    scope '/categories' do
      get '', to: 'categories#index'
    end
  end
end
