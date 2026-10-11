class HomeController < ApplicationController
  def index
    if user_signed_in? && current_user.categories.any?
      # Personalized homepage feed: Latest 3 posts from user's preferred categories
      @posts = Post.joins(:categories)
                   .where(categories: { id: current_user.category_ids })
                   .distinct
                   .order(created_at: :desc)
                   .limit(3)
    else
      # Default homepage feed: Latest 3 posts overall
      @posts = Post.order(created_at: :desc).limit(3)
    end
  end
end
