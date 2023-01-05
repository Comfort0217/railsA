class UsersController < ApplicationController
  def new
    @sign_up_form = SignUpForm.new
  end
  
  def create
    @sign_up_form = SignUpForm.new(sign_up_form_params)
    logger.debug('=======================')
    logger.debug(@sign_up_form.name)
  
    cgi = CGI.escape('https://github.com/' + @sign_up_form.name)
    res = Net::HTTP.get_response(cgi)
  
    # Headers
    res['Set-Cookie']            # => String
    res.get_fields('set-cookie') # => Array
    res.to_hash['set-cookie']    # => Array
    # puts "Headers: #{res.to_hash.inspect}"
  
    # Status
    logger.debug(res.code)
    logger.debug(res.message)
    logger.debug(res.class.name)
  
    # logger.debug(res.body)
    
    logger.debug('=======================')

    if res.code == 404
      flash.now[:danger] = 'GitHubに存在するユーザー名しか登録できません'
      render :new
    elsif @sign_up_form.name == nil
      flash.now[:danger] = 'GitHubに存在するユーザー名しか登録できません'
      render :new
    elsif @sign_up_form.save
      # session[:user_id] = @sign_up_form.user.id
      redirect_to posts_path, success: 'サインアップしました'
    else
      flash.now[:danger] = 'GitHubに存在するユーザー名しか登録できません'
      render :new
    end
  end
  
  private
  
  def sign_up_form_params
    params.require(:sign_up_form).permit(:email, :password, :password_confirmation, :name)
  end
end

  
  