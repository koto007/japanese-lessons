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
   #binding.pry
  #def this_day
   # where(:reserved_at => self.reservations.last.reserved_at.beginning_of_day..self.seservations.last.reserved_at.end_of_day)
  #end

  #def this_week
   # where(:reserved_at => (Time.zone.now.beginning_of_week..Time.zone.now))
  #end   

end
end
