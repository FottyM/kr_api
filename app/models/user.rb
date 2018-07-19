class User < ApplicationRecord
  has_many :portfolios, dependent: :destroy
  validates :email, :first_name, :last_name, :password, presence: true
  validates :email, uniqueness: true,
                    confirmation: true,
                    format: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/

  has_secure_password
end
