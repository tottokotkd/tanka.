class SessionsController < ApplicationController
  before_action :forbid_login_user, only:[:new, :create]
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:notice] = "ログインしました"
      redirect_to posts_path
    else
      flash[:danger] = "ログインに失敗しました"
      redirect_to new_session_path
    end
  end
  
  def destroy
    session.delete(:user_id)
    flash[:notice] = "ログアウトしました"
    redirect_to new_session_path
  end
end
