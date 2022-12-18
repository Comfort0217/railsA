class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :danger

  helper_method :current_user

  before_action :set_search

  def set_search
    @q = Post.ransack(params[:q])
    @posts = @q.result(distinct: true).includes(:tags).order(created_at: :desc).page(params[:page]).per(10)
  end

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def require_login
    redirect_to login_path, warning: 'ログインしてください' if current_user.blank?
  end
end
