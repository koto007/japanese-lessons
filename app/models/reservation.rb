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

#  private 
 #   def reservation_quota
  #    user.reservations.map(&:reserved_at)
   #   count = user.reservations.map(&:reserved_at).count
    #  dates = Date.parse(user.reservations.map(&:reserved_at)[0..10]).to_s
     # if user.reservations.count > 1 && dates == Date.today + 1.day
      #   errors.add(:base, "Vous avez déjà réserver un cours à ce jour-là.")
      #elsif user.reservations.count > 2
       #  errors.add(:base, "Vous pouvez réserver deux cours par semaine.")
      #end
    #end  
  
  
end
