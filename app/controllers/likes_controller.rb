class LikesController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @likes = Like.where(user_id: @user.id).reverse_order
  end
  
  def create
    @like = current_user.likes.new(post_id: params[:post_id])
    @like.save
    redirect_to post_path(params[:post_id])
  end
  
  def destroy
    @like = Like.find_by(user_id: @current_user.id, post_id: params[:post_id])
    @like.destroy
    redirect_to post_path(params[:post_id])
  end
end
