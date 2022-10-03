class SessionsController < ApplicationController
  before_action :forbid_login_user, only: [:new, :create]

  def new
  end

  def create
    @user = User.find_by(email: session_params[:email].downcase)
        if @user && @user.authenticate(session_params[:password])
          log_in(@user)
          flash[:notice] = "こんにちは。#{@user.name}さん"
          redirect_to "/"
        else
          @user = User.new(session_params)
          flash[:notice] = "メールアドレスまたはパスワードが間違っています"
          render 'new'
        end
  end

  def destroy
    log_out if logged_in?
    flash[:notice] = "ログアウトしました"
    redirect_to :login
  end

  private
      def session_params
        params.require(:session).permit(:email, :password)
      end
end
