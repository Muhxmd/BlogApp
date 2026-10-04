class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post

  def create
    @like = @post.likes.find_or_create_by(user: current_user)
    # The anchor stops the page from jumping to the top
    redirect_to post_path(@post, anchor: "likes-section")
  end

  def destroy
    @like = @post.likes.find_by(user: current_user)
    @like&.destroy
    redirect_to post_path(@post, anchor: "likes-section")
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end