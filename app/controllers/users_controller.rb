class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:show]
  require 'date' 
  require 'active_support/all'
  
  def show
    @user = User.find(params[:id])
    #binding.pry
    @weeks = ["lun","mar","mer","jeu","ven","sam","dim"]
    @today = Date.current
    #binding.pry
    @reservations_dates = @user.reservations.where("reserved_at >= ?", @today).order('reserved_at ASC').map(&:reserved_at)
    @this_monday = @today - (@today.wday - 1)

      
    if (params[:week] == '1') || (params[:week] == nil)
      @your_lesson = Time.mktime(@this_monday.year, @this_monday.month, @this_monday.day, 10, 00)
      
    elsif params[:week] == '2'
      @this_monday += 7.days
      @your_lesson = Time.mktime(@this_monday.year, @this_monday.month, @this_monday.day, 10, 00)
      
    else
      @this_monday += 14.days
      @your_lesson = Time.mktime(@this_monday.year, @this_monday.month, @this_monday.day, 10, 00)
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = 'Votre inscription a été validée.'
      redirect_to @user
    else
      flash.now[:danger] = "Votre inscription n'a pas été validée."
      render :new
    end
  end
  

  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
  def reserved_at_params
    params.require(:reservation).permit(:reserved_at)
  end
end
