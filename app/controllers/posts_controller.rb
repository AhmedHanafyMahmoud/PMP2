class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_filter :reject_locked!
  before_action :check_user, only: [:edit, :update, :destroy]
  before_action :check_admin, only: [:posts, :users]
  

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.where(user_id: current_user.id)
  end
  
  def posts
    @posts = Post.all
  end
  def users
    @users = User.all
  end
  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

  def check_user
    unless (@post.user == current_user) || (current_user.is_admin?)
      redirect_to root_url, alert: "Sorry, this post belongs to someone else"
    end
  end
  def check_admin
    unless (current_user.is_admin?)
      redirect_to root_url, alert: "You have no admin righs!"
    end
  end
    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:name, :description, :image)
    end
  def reject_locked!
    if current_user && current_user.is_locked?
      sign_out current_user
      user_session = nil
      current_user = nil
      flash[:alert] = "Your account is locked."
      flash[:notice] = nil
      redirect_to root_url
    end
  end
  helper_method :reject_locked!


    
end
