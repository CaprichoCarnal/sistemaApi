class User < ApplicationRecord
  belongs_to :role
      require "securerandom"
    has_secure_password

    validates :email, presence: true, uniqueness: true
    validates :password, presence: true, length: { minimum: 6 }
    validates :name, presence: true, uniqueness: true
end
