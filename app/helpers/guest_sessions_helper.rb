module GuestSessionsHelper
  def guest_check
    redirect_to root_path, notice: 'ゲストユーザーにはこの機能はありません' if guest_user?
  end

  private

  def guest_user?
    session[:user_id] == 100
  end
end
