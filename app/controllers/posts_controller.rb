class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]

  # GET /posts or /posts.json
 def index
  @query = params[:q].to_s.strip

  @posts = Post.order(created_at: :desc)

  if @query.present?
    search_term = "%#{Post.sanitize_sql_like(@query)}%"

    @posts = @posts
      .left_outer_joins(:rich_text_body)
      .where(
        "posts.title LIKE :term OR action_text_rich_texts.body LIKE :term",
        term: search_term
      )
  end
end
  # GET /posts/1 or /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
 def create
  @post = current_user.posts.new(post_params)

  respond_to do |format|
    if @post.save
    format.html { redirect_to my_articles_path, notice: "Post was successfully created." }
      format.json { render :show, status: :created, location: @post }
    else
      format.html { render :new, status: :unprocessable_content }
      format.json { render json: @post.errors, status: :unprocessable_content }
    end
  end
end
  # PATCH/PUT /posts/1 or /posts/1.json
def update
  if @post.update(post_params)
    redirect_to root_path, notice: "Article updated successfully."
  else
    render :edit, status: :unprocessable_entity
  end
end

  # DELETE /posts/1 or /posts/1.json
def destroy
  @post.destroy
  redirect_to root_path, notice: "Article deleted successfully."
end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
   def post_params
  params.require(:post).permit(:title, :body, :thumbnail)
end
end
