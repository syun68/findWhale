class UsersController < ApplicationController
  before_action :logged_in_user, only: %i[account profile edit profile_update update]
  before_action :forbid_login_user, only: %i[new create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = 'ユーザー登録が完了しました'
      redirect_to :root
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
      redirect_to :root
    else
      @user = User.new(user_params)
      flash[:notice] = '更新に失敗しました'
      render 'users/profile', status: :unprocessable_entity
    end
  end

  def update
    @user = User.find(@current_user.id)
    if params[:user][:password] == params[:user][:password_confirmation]
      if @user.authenticate(params[:user][:current_password])\
         && @user.authenticate(params[:user][:current_password]).password_digest == @user.current_password
        if @user.update(user_params)
          flash[:notice] = 'ユーザー情報を更新しました'
          redirect_to :users_profile
        else
          @user = User.new(user_params)
          flash[:notice] = '更新に失敗しました'
          render 'users/edit', status: :unprocessable_entity
        end
      else
        flash[:notice] = '現在のパスワードを正しく入力してください'
        render 'users/edit', status: :unprocessable_entity
      end
    else
      flash[:notice] = '変更するパスワードを正しく入力してください'
      render 'users/edit', status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(@current_user.id)
    @user.destroy
    flash[:notice] = 'アカウントを削除しました'
    redirect_to root_path
  end

  private

  def user_params
    params
      .require(:user)
      .permit(
        :name, :email, :introduction,
        :password, :password_confirmation, :current_password, :avatar
      )
  end
end
