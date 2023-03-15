class GuestSessionsController < ApplicationController
  def create
    @user = User.find_or_create_by(email: "guest@example.com") do |user|
      user.password = "hogehoge"
      user.password_confirmation = "hogehoge"
      user.name = "ゲスト"
    end
    log_in(@user)
    flash[:notice] = "ゲストユーザーとしてログインしました"
    redirect_to :root
  end
end
