class User < ActiveRecord::Base

  validates :username, uniqueness: true
  validates :username, :password_digest, presence: true

  has_secure_password

  has_many :inventory
  has_many :shopping_list
  has_many :project

  def add_spool(spool, amount = 1)
    if Inventory.where(:user_id => self.id).exists?(:spools_id => spool.id)
      inventory = Inventory.find_by(:user_id => self.id, :spools_id => spool.id)
      inventory.amount += BigDecimal(amount)
      inventory.save
    else
      inventory = Inventory.new(user_id: self.id, spools_id: spool.id, amount: amount)
      inventory.save
    end
    self.save
  end

  def add_to_shopping(spool, amount = 1)
    if ShoppingList.where(:user_id => self.id).exists?(:spools_id => spool.id)
      list = Inventory.find_by(:user_id => self.id, :spools_id => spool.id)
      list.amount += amount
      list.save
    else
      list = ShoppingList.new(user_id: self.id, spools_id: spool.id, amount: amount)
      list.save
    end
    self.save
  end

end
