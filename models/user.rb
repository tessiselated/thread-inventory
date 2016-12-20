class User < ActiveRecord::Base

  validates :username, uniqueness: true
  validates :username, :password_digest, presence: true

  has_secure_password

  has_many :inventory
  has_one :shopping_list

  def add_spool(spool)
    inventory = Inventory.new(user_id: self.id, spools_id: spool.id)
    inventory.save
    self.save
  end

end
