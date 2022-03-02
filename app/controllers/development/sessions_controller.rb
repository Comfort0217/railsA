class Development::SessionsController < ApplicationController
  def login_as
    user = User.find(params[:user_id])
    session[:user_id] = user.id
    redirect_to posts_path
  end
end
