class LikesController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @likes = Like.where(user_id: @user.id).reverse_order
  end

  def create
    @posts = Post.all
    @post = Post.find(params[:post_id])
    @likes = Like.where(post_id: params[:post_id])
    respond_to do |format|
      @like = current_user.likes.create(post_id: params[:post_id])
      format.js{ render :create }
    end
  end

  def destroy
    @posts = Post.all
    @post = Post.find(params[:post_id])
    @likes = Like.where(post_id: params[:post_id])
    @like = Like.find_by(user_id: current_user.id, post_id: params[:post_id])
    respond_to do |format|
      @like.destroy
      format.js{ render :destroy}
    end
  end
end
