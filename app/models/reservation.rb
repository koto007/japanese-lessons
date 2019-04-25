class Reservation < ApplicationRecord
  
  belongs_to :user
  
  def available?
    Reservation.where(:user_id => @user.id, :reserved_at => @reservation.id).exists?
  end
  
  
end
