# app/models/category.rb
class Category < ApplicationRecord
  has_many :article_categories, dependent: :destroy
  has_many :articles, through: :article_categories

  has_many :user_categories, dependent: :destroy
  has_many :users, through: :user_categories

  validates :name, presence: true, uniqueness: true
end
