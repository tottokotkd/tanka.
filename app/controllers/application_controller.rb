class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  
  before_action :current_user
  
  def authenticate_user
    if @current_user == nil
      flash[:danger] = "ログインしてください"
      redirect_to new_session_path
    end
  end
  
  def forbid_login_user
    if @current_user
      flash[:danger] = "すでにログインしています"
      redirect_to posts_path
    end
  end
end
