class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email_params)
    if user && user.authenticate(password_params[:password])
      log_in user
      flash[:success] = "ログインに成功しました"
      redirect_to topics_path
    else
      flash.now[:danger] = 'ログインに失敗しました'
      render "new"
    end
  end

  def destroy
    log_out
    redirect_to root_url, info: 'ログアウトしました'
  end

  private
  def email_params
    params.require(:session).permit(:email)
  end

  def password_params
    params.require(:session).permit(:password)
  end

  def log_in(user)
    session[:user_id] = user.id
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end
