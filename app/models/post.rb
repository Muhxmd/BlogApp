class Post < ApplicationRecord
  has_rich_text :body
  has_one_attached :thumbnail
end

class Post < ApplicationRecord
  belongs_to :user
  has_rich_text :body
  has_one_attached :thumbnail
end