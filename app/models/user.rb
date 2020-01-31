class User < ApplicationRecord
    has_many :blogs, dependent: :destroy
    validates :name, presence: true
    validates :password, presence: true, length: { minimum: 6 }
    validates :email, presence: true, length: {maximum: 255}, 
                    format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, uniqueness: true

    before_save { self.email = email.downcase }
    has_secure_password
   
end
