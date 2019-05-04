class SessionsController < ApplicationController
  def new
  end

  def create
    email = params[:session][:email].downcase
    password = params[:session][:password]
    if login(email, password)
      flash[:success] = 'Vous avez réussi à vous connecter.'
      redirect_to @user
    else 
      flash.now[:danger] = "Vous n'avez pas réussi à vous vous connecter, réessayez"
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = 'Vous vous êtes déconnecté.'
    redirect_to root_url
  end
  
  private 
  def login(email, password)
    @user = User.find_by(email: email)
    if @user && @user.authenticate(password)
      session[:user_id] = @user.id
      return true
    else
      return false
    end
  end
end
