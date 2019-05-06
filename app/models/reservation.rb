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
  
  validate :day_quota, :on => :create 
  validate :week_quota, :on => :create 


  private 
    def day_quota
      unless self.user.admin == true
        if self.user.reservations.count >= 1 && self.user.reservations.where(:reserved_at => self.reserved_at.beginning_of_day..self.reserved_at.end_of_day).exists?
          errors.add(:base, "Vous pouvez réserver un cours par jour, vous avez déjà un cours réservé à ce jour-là.")
        end
      end    
    end

    def week_quota
      unless self.user.admin == true
        if self.user.reservations.count >= 2 && self.user.reservations.where(:reserved_at => self.reserved_at.beginning_of_day..self.reserved_at.end_of_day + 7.days).exists?
          errors.add(:base, "Vous pouvez réserver deux cours par semaine, vous avez déjà réservé deux cours à cette semaine.")
        end
      end         
    end
      #elsif self.user.reservations.count >= 2 && self.user.reservations.where(:reserved_at => self.reserved_at.beginning_of_day..self.reserved_at.end_of_day + 7.days).exists?
       # errors.add(:base, "Vous avez déjà réservé deux cours à cette semaine.")
      #end         
      #if user.reservations 
       # if user.reservations.count >= 1 && user.reservations.this_day.exists?
        #   
      #  elsif user.reservations.count >= 2 && user.reservations.this_week.exists?
       #   errors.add(:base, "Vous pouvez réserver deux cours par semaine.")
      #  end
      #end
    #end
end
