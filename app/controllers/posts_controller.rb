class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :set_user_id, only: %i[ new show edit update destroy ]


  # GET /posts or /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1 or /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    if (isLogin)
      @post = Post.new
    end
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @user_param = params[:post][:user_id]
    if isLogin && isCorrectUser
      @post = Post.new(post_params)
      respond_to do |format|
        if @post.save
          # format.html { redirect_to @post, notice: "Post was successfully created." }
          format.html { redirect_to "/feed", notice: "Post was successfully created." }
          format.json { render :show, status: :created, location: @post }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
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
    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:message, :user_id)
    end

    def set_user_id
      @user_id = session[:user_id]
    end

    def isLogin
      if (session[:user_id])
          return true
      else
          redirect_to "/main", alert: "Please login"
          return false
      end 
    end

    def isCorrectUser
      puts @user_param
      puts 
      puts session[:user_id]
      if  (@user_param.to_i == session[:user_id])
          return true
      else
          redirect_to "/main", alert: "Access denied"
          return false
      end 
    end
end
