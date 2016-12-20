class User < ActiveRecord::Base

  validates :username, uniqueness: true
  validates :username, :password_digest, presence: true

  has_secure_password

  has_one :inventory
  has_one :shopping_list

end
