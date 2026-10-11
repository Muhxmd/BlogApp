class Post < ApplicationRecord
  # Existing relationships and attachments
  belongs_to :user
  has_rich_text :body
  has_one_attached :thumbnail
has_many :post_categories, dependent: :destroy
  has_many :categories, through: :post_categories
  # New relationships for the features we are building
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
end
