class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :logged_in, except: %i[]

  # GET /posts or /posts.json
  def index
    @posts = Post.all
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
    @post = Post.new(post_params)
    check = @post.check_session(get_session_data)
    respond_to do |format|
      if check && @post.save
        format.html { redirect_to @post, notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    check = true

    if (get_session_data.to_s != params[:post][:user_id])
      check = @post.addErrorUpdate
    elsif(!check)
      check = @post.check_session(get_session_data)
    end

    respond_to do |format|
      if check && @post.update(post_params)
        format.html { redirect_to @post, notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy
    if check
      respond_to do |format|
        format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
        format.json { head :no_content }
      end
    else
      redirect_to posts_url
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      if(Post.find_by_id(params[:id]) == nil)
        redirect_to posts_url
      else
        @post = Post.find(params[:id])
      end

    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:user_id, :msg)
    end






    def get_session_data
      return session[:user_id]
    end

    def logged_in
      if get_session_data != nil
        return true
      else
        redirect_to main_path , notice: "Please login"
      end
    end
end
