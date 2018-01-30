class LikesController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @likes = Like.where(user_id: @user.id).reverse_order
  end

  def create
    @like = current_user.likes.create(post_id: params[:post_id])
    @like.save
    # redirect_to post_path(@like.post_id)
    @posts = Post.all
    @post = Post.find(params[:post_id])
    @likes = Like.where(post_id: params[:post_id])
  end

  def destroy
    @like = current_user.likes.find_by(post_id: params[:post_id])
    @like.destroy
    # redirect_to posts_path
    @posts = Post.all
    @post = Post.find(params[:post_id])
    @likes = Like.where(post_id: params[:post_id])
  end
end
