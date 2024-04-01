class User < ApplicationRecord
   validates_presence_of :name, :email, :password, :password_confirmation
   validates :email, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
   validates :password, confirmation: true

   has_secure_password

   has_many :user_parties
   has_many :viewing_parties, through: :user_parties
end
