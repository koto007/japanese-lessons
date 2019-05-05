class User < ApplicationRecord
  
  has_many :reservations 
  
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false } 
  validates :password, presence: true, length: { minimum: 6 }                  
  has_secure_password

  def book(reserved_at)
    self.reservations.build(reserved_at: reserved_at)
  end
  
#has_many :reservations do
 #  def this_day(reserved_at)
  #  where(:reserved_at => self.last.reserved_at.beginning_of_day..self.last.reserved_at.end_of_day)
   #end

#  def this_week(reserved_at)
 #   where(:reserved_at => self.last.reserved_at.beginning_of_day..self.last.reserved_at + 7.days.end_of_day)
  #end   

#end
end
