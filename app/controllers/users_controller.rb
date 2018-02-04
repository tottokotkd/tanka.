class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :edit_confirm, :update, :leaving, :destroy, :ensure_correct_user]
  before_action :authenticate_user, only: [:show, :edit, :update]
  before_action :forbid_login_user, only:[:new, :create]
  before_action :ensure_correct_user, only: [:edit, :update]

  def new
    if params[:back]
      @user = User.new(user_params)
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Tanka.へようこそ！"
      redirect_to posts_path
    else
      render "new"
    end
  end

  def new_confirm
    @user = User.new(user_params)
    render  "new" if @user.invalid?
  end

  def show
    @likes = @user.likes
  end

  def edit
    if params[:back]
      @user.attributes = user_params
    end
  end

  def edit_confirm
    @user.attributes = user_params
    render "edit" if @user.invalid?
  end

  def update
    @user.attributes = user_params
    @user.image.retrieve_from_cache!(params[:cache][:image]) if params[:cache][:image].present?
    if @user = User.update(user_params)
      flash[:notice] = "プロフィールを編集しました"
      redirect_to user_path(params[:id])
    else
      render "edit"
    end
  end

  def leaving
  end

  def destroy
    @user.destroy
    session.delete(:user_id)
    flash[:notice] = "ユーザー情報を削除しました。\nご利用ありがとうございました。"
    redirect_to new_session_path
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :description, :image, :image_cache)
    end

    def set_user
      @user = User.find(params[:id])
    end

    def ensure_correct_user
      if @current_user.id != params[:id].to_i
        flash[:danger]="権限がありません"
        redirect_to posts_path
      end
    end
end
