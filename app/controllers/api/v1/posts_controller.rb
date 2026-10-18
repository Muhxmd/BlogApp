
class Api::V1::PostsController < ApplicationController
  before_action :authenticate_api_user!, only: [ :create, :update, :destroy ]

  def index
    page = params.fetch(:page, 1).to_i
    per_page = params.fetch(:per_page, 10).to_i

    page = 1 if page < 1
    per_page = 10 if per_page < 1
    per_page = 100 if per_page > 100

    total_posts = Post.count

    posts = Post.order(created_at: :desc, id: :desc)
                .offset((page - 1) * per_page)
                .limit(per_page)

    render json: {
      posts: posts,
      pagination: {
        page: page,
        per_page: per_page,
        total_posts: total_posts,
        total_pages: (total_posts.to_f / per_page).ceil
      }
    }
  end

  def show
    post = Post.find(params[:id])
    render json: post
  end

  def create
    post = current_user.posts.build(post_params)

    if post.save
      render json: post, status: :created
    else
      render json: post.errors, status: :unprocessable_entity
    end
  end

  def update
    post = current_user.posts.find(params[:id])

    if post.update(post_params)
      render json: post, status: :ok
    else
      render json: post.errors, status: :unprocessable_entity
    end
  end

  def destroy
    post = current_user.posts.find(params[:id])
    post.destroy

    head :no_content
  end

  private

  def authenticate_api_user!
    unless user_signed_in?
      render json: { error: "Unauthorized" }, status: :unauthorized
    end
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
