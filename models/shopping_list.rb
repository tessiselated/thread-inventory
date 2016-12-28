class ShoppingList < ActiveRecord::Base
  belongs_to :user
  has_many :spools

  def buy_spool
    user.add_spool((Spool.find(self.spools_id)), self.amount)
    self.delete
    user.save
  end
  #
  # def buy!
  #   spools.each do |sp|
  #     user.inventory.add_spool(sp)
  #     spools.delete(sp)
  #   end
  #   save
  # end

end
