class Admin::PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]
  
  # GET /posts or /posts.json
  def index
    @posts = policy_scope(Post)
  end

  # GET /posts/1 or /posts/1.json
  def show
    @post = Post.find(params[:id])
    authorize @post
  end

  # GET /posts/new
  def new
    @post = Post.new
    authorize @post
  end

  # GET /posts/1/edit
  def edit
    authorize @post
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)
    authorize @post

    respond_to do |format|
      if @post.save
        format.html { redirect_to admin_post_url(@post), notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        puts "Post Errors: #{@post.errors.full_messages}"
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    authorize @post
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to admin_post_url(@post), notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        puts "Post Errors: #{@post.errors.full_messages}"
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy
    authorize @post

    respond_to do |format|
      format.html { redirect_to admin_posts_path, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find_by(id: params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :discription, :status)
    end
end