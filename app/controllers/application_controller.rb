class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  include SessionsHelper
  
  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end

  def admin?
    !! current_user.admin == true
  end
  
  def require_user_admin
    unless admin?
      redirect_to root_url
    end
  end
#  def admin?
#    unless admin == false
#      return true
#    else 
#      return false
#    end
#  end

end
