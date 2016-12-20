class User < ActiveRecord::Base

  validates :username, uniqueness: true
  validates :username, :password, presence: true

  has_one :inventory
  has_one :shopping_list

end
