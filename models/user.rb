class User < ActiveRecord::Base

  validates :username, uniqueness: true
  validates :username, :password, presence: true






end
