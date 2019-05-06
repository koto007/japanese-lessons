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
    @reservations_dates = Reservation.all.order('reserved_at ASC').map(&:reserved_at)
  end
  
  def new
    @reservation = Resesrvation.new
    #@user = User.new
  end

  def create

  
    #@reservation = current_user.reservations.build(reserved_at: params[:reserved_at])
    
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
    @reservation = current_user.book(params[:reserved_at])
    if @reservation.save 
      flash[:success] = 'Votre cours a été réservé. Je vous enverrai un mail de confirmation sous 24 heures.'
      redirect_to current_user
    else
      render 'index'
      #flash[:danger] = 'Vous pouvez réserver un cours par jour, deux cours par semaine.'
    end 
  end
  

  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy
    flash[:success] = 'Votre réservation a été annulé.'
    redirect_to root_url
  end

end
