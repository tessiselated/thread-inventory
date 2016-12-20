class ShoppingList < ActiveRecord::Base
  belongs_to :user
  has_many :spools

  def add(spool)
    spools << spool
    self.save
  end

  def buy!
    spools.each do |sp|
      user.inventory.add_spool(sp)
      spools.delete(sp)
    end
    save
  end

end
