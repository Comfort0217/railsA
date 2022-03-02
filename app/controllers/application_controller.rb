class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :danger

  helper_method :current_user

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def require_login
    redirect_to login_path, warning: 'ログインしてください' if current_user.blank?
  end
end
