class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]

  # GET /posts or /posts.json
  def index
    @query = params[:q].to_s.strip

    # 1. CATEGORY FEED LOGIC
    # If the user is signed in and has selected preferred categories, show those first.
    # Otherwise, show all posts.
    if user_signed_in? && current_user.categories.any?
      @posts = Post.joins(:categories)
                   .where(categories: { id: current_user.category_ids })
                   .distinct
                   .order(created_at: :desc)
    else
      @posts = Post.order(created_at: :desc)
    end

    # 2. SEARCH LOGIC (Works on top of the category feed)
    if @query.present?
      search_term = "%#{Post.sanitize_sql_like(@query.downcase)}%"
      @posts = @posts
        .left_outer_joins(:rich_text_body)
        .where(
          "LOWER(posts.title) LIKE :term OR LOWER(action_text_rich_texts.body) LIKE :term",
          term: search_term
        )
    end

    # 3. PAGINATION
    @pagy, @posts = pagy(@posts, limit: 5)
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
    @post = current_user.posts.build(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @post.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: "Article updated successfully." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @post.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy

    respond_to do |format|
      format.html do
        redirect_to posts_path,
          status: :see_other,
          notice: "Article deleted successfully."
      end
      format.json { head :no_content }
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    # Removed :user_id for security and added category_ids: []
    params.require(:post).permit(:title, :body, category_ids: [])
  end
end