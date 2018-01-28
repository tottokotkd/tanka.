class CommentsController < ApplicationController
  before_action :ensure_correct_comment, only:[:edit, :update, :destroy]

  def index
    @post = Post.find(params[:post_id])
    @comments = @post.comments.all.reverse_order
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.new(content: params[:comment][:content], post_id:params[:post_id])
    respond_to do |format|
      if @comment.save
        format.js{ render :index }
      else
        format.html{ redirect_to post_path(@post.id), notice: "投稿に失敗しました" }
      end
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.find(params[:id])
    respond_to do |format|
      @comment.destroy
      format.js{ render :index }
    end
  end

  private
    def ensure_correct_comment
      @comment = Comment.find(params[:id])
      if @current_user.id != @comment.user_id
        flash[:danger]="権限がありません"
        redirect_to post_path(@comment.post_id)
      end
    end
end

