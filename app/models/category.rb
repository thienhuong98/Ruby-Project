class Category < ApplicationRecord
    has_one_attached :image
    has_and_belongs_to_many :words
    has_many :categories_test
    has_and_belongs_to_many :tests
    has_many :questions, dependent: :destroy
    before_destroy do
        words.clear
        tests.clear
    end
    VALID_NAME_REGEX = /\A[a-z]+[a-z0-9 ]*\z/i
    validates :name, presence: true, length: { minimum: 6 }, format: {with: VALID_NAME_REGEX}
end