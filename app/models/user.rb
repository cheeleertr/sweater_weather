class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  has_many :api_keys, as: :bearer 
  has_secure_password
end
