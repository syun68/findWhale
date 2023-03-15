module GuestSessionsHelper
  def guest_check
    if @current_user == User.find(100)
      redirect_to root_path,notice: "ゲストユーザーにはこの機能はありません。"
    end
  end
end
