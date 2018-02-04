class PostsController < ApplicationController
  before_action :set_post, only:[:show, :edit, :edit_confirm, :update, :destroy, :ensure_correct_post]
  before_action :authenticate_user
  before_action :ensure_correct_post, only: [:edit, :update]

  def index
    @posts = Post.all.reverse_order
  end

  def show
    @comments = @post.comments
    @comment = current_user.comments.new
    @like = current_user.likes.find_by(post_id: @post.id)
    @likes_count = @post.likes.count
  end

  def new
    if params[:back]
      @post = current_user.posts.new(post_params)
    else
      @post = current_user.posts.new
    end
  end

  def new_confirm
    @post = current_user.posts.new(post_params)
    render "new" if @post.invalid?
  end

  def create
    @post = current_user.posts.new(post_params)
    @post.image.retrieve_from_cache!(params[:cache][:image]) if params[:cache][:image].present?
    if @post.save
      flash[:notice] = "あたらしい作品を投稿しました \"#{@post.content.truncate(10)}\""
      redirect_to posts_path
    else
      render "new"
    end
  end

  def edit
    if params[:back]
      @post.attributes = post_params
    end
  end

  def edit_confirm
    @post.attributes = post_params
    render "edit" if @post.invalid?
  end

  def update
    @post.attributes = post_params
    @post.image.retrieve_from_cache!(params[:cache][:image]) if params[:cache][:image].present?
    if @post.save
      flash[:notice] = "作品を編集しました \"#{@post.content.truncate(10)}\""
      redirect_to post_path(@post.id)
    else
      render "edit"
    end
  end

  def destroy
    @post.destroy
    flash[:notice] = "作品を削除しました"
    redirect_to posts_path
  end

  private
    def post_params
      params.require(:post).permit(:content, :image, :image_cache, :remove_image)
    end

    def set_post
      @post = Post.find(params[:id])
    end

    def ensure_correct_post
      if @current_user.id != @post.user_id
        flash[:danger]="権限がありません"
        redirect_to post_path(@post.id)
      end
    end
end
