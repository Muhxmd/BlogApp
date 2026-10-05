class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post

  def create
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to post_path(@post, anchor: "likes-section"), notice: "Comment added successfully."
    else
      redirect_to post_path(@post, anchor: "likes-section"), alert: "Comment could not be saved."
    end
  end

  def destroy
    @comment = @post.comments.find(params[:id])

    if @comment.user == current_user
      @comment.destroy
      redirect_to post_path(@post, anchor: "likes-section"), notice: "Comment deleted."
    else
      redirect_to post_path(@post, anchor: "likes-section"), alert: "You are not authorized to delete this comment."
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
