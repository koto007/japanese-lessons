class User < ApplicationRecord
  
  has_many :reservations 
  
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false } 
  has_secure_password
  
  def book(reserved_at)
    self.reservations.build(reserved_at: reserved_at)
  end
  
  #def reservations
  
  #end
  
  #def unbook(reservation)
    #@user = User.find(params[:id])
    #reservation.destroy
  #end
end
