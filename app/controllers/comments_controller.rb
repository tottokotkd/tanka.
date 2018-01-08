class CommentsController < ApplicationController
  before_action :ensure_correct_comment, only:[:edit, :update, :destroy]
  def index
    @post = Post.find(params[:post_id])
    @comments = @post.comments.all.reverse_order
  end
  
  def new
    @comment = current_user.comments.new(post_id: params[:post_id])
  end
  
  def create
    @comment = current_user.comments.new(content: params[:comment][:content], post_id: params[:post_id])
    if @comment.save
      flash[:notice] = "感想を投稿しました"
      redirect_to post_path(@comment.post_id)
    else
      render "new"
    end  
  end
  
  def edit
    @comment = current_user.comments.find(params[:id])
  end
  
  def update
    @comment = current_user.comments.find(params[:id])
    if @comment.update(content: params[:comment][:content], post_id: params[:post_id])
      flash[:notice] = "感想を編集しました"
      redirect_to post_path(@comment.post_id)
    else
      render "edit"
    end
  end
  
  def destroy
    @comment = current_user.comments.find(params[:id])
    flash[:notice] = "感想を削除しました"
    @comment.destroy
    redirect_to post_path(@comment.post_id)
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

