class Reservation < ApplicationRecord
  
  belongs_to :user
  
 # def available?
  #  Reservation.where(:user_id => @user.id, :reserved_at => @reservation.id).exists?
  #end
  
    def not_available
    unless @reservation.where(:reserved_at => nil)
      return true
    else
      return false
    end
  end
  
  validate :reservation_quota, :on => :create 

  private 
    def reservation_quota
      #binding.pry
       if user.reservations.where(:reserved_at => user.reservations.last.reserved_at.beginning_of_day..user.reservations.last.reserved_at.end_of_day).exists?
       
         errors.add(:base, "Vous avez déjà réserver un cours à ce jour-là.")
      #elsif user.reservations.count > 2
       #  errors.add(:base, "Vous pouvez réserver deux cours par semaine.")
      end
    end  
  end

