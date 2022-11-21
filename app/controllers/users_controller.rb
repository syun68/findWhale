# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :logged_in_user, only: %i[account profile edit profile_update update]
  before_action :forbid_login_user, only: %i[new create]

  def top; end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = 'ユーザー登録が完了しました'
      redirect_to '/'
    else
      render 'users/new', status: :unprocessable_entity
    end
  end

  def account; end

  def profile
    @user = User.find(@current_user.id)
  end

  def edit
    @user = User.find(@current_user.id)
  end

  def profile_update
    @user = User.find(@current_user.id)
    if @user.update(user_params)
      flash[:notice] = 'プロフィール情報を更新しました'
      redirect_to '/'
    else
      @user = User.new(user_params)
      flash[:notice] = '更新に失敗しました'
      render 'users/profile', status: :unprocessable_entity
    end
  end

  def update
    @user = User.find(@current_user.id)
    if @user.update(user_params)
      flash[:notice] = 'ユーザー情報を更新しました'
      redirect_to :users_profile
    else
      @user = User.new(user_params)
      flash[:notice] = '更新に失敗しました'
      render 'users/profile', status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.
    require(:user).
    permit(:name, :email, :introduction, :password, :password_confirmation, :avatar)
  end
end
