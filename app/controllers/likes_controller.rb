class LikesController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @likes = Like.where(user_id: @user.id).reverse_order
  end

  def create
    current_user.likes.create(post_id: params[:post_id])
    # redirect_to post_path(@like.post_id)
    @posts = Post.all
    @post = Post.find(params[:post_id])
    @like = current_user.likes.find_by(post_id: @post.id)
    @likes = Like.where(post_id: params[:post_id])
  end

  def destroy
    Like.find(params[:id]).destroy
    # redirect_to posts_path
    @posts = Post.all
    @post = Post.find(params[:post_id])
    @like = current_user.likes.find_by(post_id: @post.id)
    @likes = Like.where(post_id: params[:post_id])
  end
end
