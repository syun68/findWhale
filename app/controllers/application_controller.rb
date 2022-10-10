class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :set_current_user
  skip_before_action :verify_authenticity_token

  private
  # ログイン済みユーザーかどうか確認
  def logged_in_user
    unless logged_in?
      flash[:notice] = "ログインが必要です"
      redirect_to :login
    end
  end

  def forbid_login_user
    if logged_in?
      flash[:notice] = "すでにログインしています"
      redirect_to "/"
    end
  end
end
