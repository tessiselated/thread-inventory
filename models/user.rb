class User < ActiveRecord::Base

  validates :username, uniqueness: true
  validates :username, :password_digest, presence: true

  has_secure_password

  has_many :inventories
  has_many :shopping_lists
  has_many :projects

  def add_spool(spool, amount = 1)
    if Inventory.where(:user_id => self.id).exists?(:spools_id => spool.id)
      inventory = Inventory.find_by(:user_id => self.id, :spools_id => spool.id)
      inventory.amount += BigDecimal(amount, 4)
      if inventory.amount < 0
        return false
      end
      inventory.save
    else
      inventory = Inventory.new(user_id: self.id, spools_id: spool.id, amount: amount)
      if inventory.amount < 0
        return false
      end
      inventory.save
    end
    self.save
  end

  def add_to_shopping(spool, amount = 1)
    if ShoppingList.where(:user_id => self.id).exists?(:spools_id => spool.id)
      list = ShoppingList.find_by(:user_id => self.id, :spools_id => spool.id)
      list.amount += amount.to_i
      list.save
    else
      list = ShoppingList.new(user_id: self.id, spools_id: spool.id, amount: amount)
      list.save
    end
    self.save
  end

  def new_project(spoolids, name)
    project = Project.new(user_id: self.id, name: name)
    project.spool_ids = spoolids
    project.save
    self.save
  end

end
