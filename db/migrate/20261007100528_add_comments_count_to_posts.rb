class AddCommentsCountToPosts < ActiveRecord::Migration[7.0]
  def change
    # default: 0 and null: false ensure the database always has a safe starting number
    add_column :posts, :comments_count, :integer, default: 0, null: false
  end
end
