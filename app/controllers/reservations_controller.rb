class ReservationsController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show]
  require 'date' 
  require 'active_support/all'
  
  def index
    @today = Date.today
    @now = Time.now
    @this_monday = @today - (@today.wday - 1)
    #@date_test = @this_monday.strftime("%-d %m %Y")
    @next_lesson = Time.mktime(@this_monday.year, @this_monday.month, @this_monday.day, 10, 00)
    @weeks = ["lun","mar","mer","jeu","ven","sam","dim"]
    
    #@index = (@this_monday + number.day).strftime("%u").to_i

  end

  def show
    @user = User.find(params[:id])
  end
  
  def new
    @reservation = Resesrvation.new
    @user = User.new
  end

  def create
    #@weeks = ["lun","mar","mer","jeu","ven","sam","dim"]
    #@your_lesson = params[:reserved_at]
    #@lesson = @your_lesson.strftime("%-H h %-M %-d %m %Y")
    #@index = (@your_lesson).strftime("%u").to_i
    
    @reserved_at = current_user.book(:reserved_at)
    if @reserved_at.save 
      flash[:success] = 'Votre cours a été réservé.'
      redirect_to current_user
    else
      render 'index'
    end 
  end
  
  #def valider
    #binding.pry
    #@reservation = current_user.reservations.find(params[:id])
    #@reservation = current_user.reservations.where(reserved_at: params[:reserved_at])
    #if @reservation.save
      #flash[:success] = 'Votre cours a été réservé.'
      #redirect_to @user
    #else
      #render 'index'
    #end
  

  
  def update
  end

  def destroy
  end
  
  def available?
    Reservation.where(:user_id => @user.id, :reserved_at => @reservation.id).exists?
  end
  #private
  

  #def correct_user 
    #@reserved_at = current_user.reservation.find_by(id: params[:id])
    #unless @resereved_at
      #redirect_to root_url
    #end
  #end
end
