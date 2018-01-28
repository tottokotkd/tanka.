class LikesController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @likes = Like.where(user_id: @user.id).reverse_order
  end

  def create
    @like = current_user.likes.create(post_id: params[:post_id])
    redirect_to post_path(@like.post_id)
  end

  def destroy
    Like.find(params[:id]).destroy
    redirect_to posts_path
  end
end
