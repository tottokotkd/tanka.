class PostsController < ApplicationController
  before_action :set_post, only:[:edit, :edit_confirm, :destroy]
  before_action :authenticate_user
  before_action :ensure_correct_post, only: [:edit, :update]
  
  def index
    @posts = Post.all.reverse_order
  end
  
  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
    @likes_count = @post.likes.count
  end
  
  def new
    if params[:back]
      @post = current_user.posts.new(post_params)
    else
      @post = current_user.posts.new
    end
  end
  
  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      flash[:notice] = "あたらしい作品を投稿しました \"#{@post.content.truncate(10)}\""
      redirect_to posts_path
    else
      render "new"
    end
  end
  
  def new_confirm
    @post = current_user.posts.new(post_params)
    render "new" if @post.invalid?
  end
  
  def edit
    if params[:back]
      @post.attributes = post_params
    end
  end
  
  def update
    if @post.update(post_params)
      flash[:notice] = "作品を編集しました \"#{@post.content.truncate(10)}\""
      redirect_to post_path(@post.id)
    else
      render "edit"
    end
  end

  def edit_confirm
    @post.attributes = post_params
    render "edit" if @post.invalid?
  end
  
  def destroy
    @post = current_user.posts.find(params[:id])
    @post.destroy
    flash[:notice] = "作品を削除しました"
    redirect_to posts_path
  end

  private
    def post_params
      params.require(:post).permit(:content)
    end
    
    def set_post
      @post = current_user.posts.find(params[:id])
    end
    
    def ensure_correct_post
      @post = Post.find(params[:id])
      if @current_user.id != @post.user_id
        flash[:danger]="権限がありません"
        redirect_to post_path(@post.id)
      end
    end
end
