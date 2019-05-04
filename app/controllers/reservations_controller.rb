class ReservationsController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show]
  require 'date' 
  require 'active_support/all'
  
  def index
      @weeks = ["lun","mar","mer","jeu","ven","sam","dim"]
      @today = Date.current
      @this_monday = @today - (@today.wday - 1)
      reservations = current_user.reservations.map(&:reserved_at)
      reservations.each do |reservation|
        @reservation = Time.new(reservation.year, reservation.month, reservation.day)
      end 
      if (params[:week] == '1') || (params[:week] == nil)
        @next_lesson = Time.mktime(@this_monday.year, @this_monday.month, @this_monday.day, 10, 00).in_time_zone("Paris")
      
      elsif params[:week] == '2'
        @this_monday += 7.days
        @next_lesson = Time.mktime(@this_monday.year, @this_monday.month, @this_monday.day, 10, 00).in_time_zone("Paris")
      
      else
        @this_monday += 14.days
        @next_lesson = Time.mktime(@this_monday.year, @this_monday.month, @this_monday.day, 10, 00).in_time_zone("Paris")
    end
    
   

  end

  def show
      @weeks = ["lun","mar","mer","jeu","ven","sam","dim"]
      @today = Date.current
      @this_monday = @today - (@today.wday - 1)    
      if (params[:week] == '1') || (params[:week] == nil)
        @next_lesson = Time.mktime(@this_monday.year, @this_monday.month, @this_monday.day, 10, 00).in_time_zone("Paris")
      
      elsif params[:week] == '2'
        @this_monday += 7.days
        @next_lesson = Time.mktime(@this_monday.year, @this_monday.month, @this_monday.day, 10, 00).in_time_zone("Paris")
      
      else
        @this_monday += 14.days
        @next_lesson = Time.mktime(@this_monday.year, @this_monday.month, @this_monday.day, 10, 00).in_time_zone("Paris")
      end
    @reservations = Reservation.all.order('reserved_at ASC')
  end
  
  def new
    @reservation = Resesrvation.new
    #@user = User.new
  end

  def create
    #@weeks = ["lun","mar","mer","jeu","ven","sam","dim"]
    #@your_lesson = params[:reserved_at]
    #@lesson = @your_lesson.strftime("%-H h %-M %-d %m %Y")
    #@index = (@your_lesson).strftime("%u").to_i
   
    #@reservation = current_user.book(params[:reserved_at])
    @reservation = current_user.reservations.build(reserved_at: params[:reserved_at])
    if @reservation.save 
      flash[:success] = 'Votre cours a été réservé. Je vous enverrons un mail de confirmation sous 24 heures.'
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

  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy
    flash[:success] = 'Votre réservation a été annulé.'
    redirect_to root_url
  end
  

  private

  
  #def reserved_at_params
   # params.require(:reservation).permit(:reserved_at)
    
  #end
  #def correct_user 
    #@reserved_at = current_user.reservation.find_by(id: params[:id])
    #unless @resereved_at
      #redirect_to root_url
    #end
  #end
end
