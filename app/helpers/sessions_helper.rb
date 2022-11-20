# frozen_string_literal: true

module SessionsHelper
  # 引数のユーザーでログイン
  def log_in(user)
    session[:user_id] = user.id
  end

  # ログイン済みユーザーかどうか確認
  def logged_in_user
    return if logged_in?

    flash[:notice] = 'ログインが必要です'
    redirect_to :login
  end

  def forbid_login_user
    return unless logged_in?

    flash[:notice] = 'すでにログインしています'
    redirect_to '/'
  end
end
