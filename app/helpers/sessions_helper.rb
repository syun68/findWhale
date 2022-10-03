module SessionsHelper
# 引数のユーザーでログイン
  def log_in(user)
    session[:user_id] = user.id
  end

# 現在ログイン中のユーザーを返す（いる場合）
  def set_current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end

# 引数のユーザーがログイン中のユーザーと一致すれば true を返す
  def current_user?(user)
    user == @current_user
  end

# ユーザーがログインしていれば true、その他なら false を返す
  def logged_in?
    !@current_user.nil?
  end

# 現在のユーザーをログアウト
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

end
