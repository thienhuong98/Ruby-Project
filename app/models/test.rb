class Test < ApplicationRecord
    has_and_belongs_to_many :categories
    has_and_belongs_to_many :questions
    belongs_to :user
end
