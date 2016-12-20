class Inventory < ActiveRecord::Base
  belongs_to :user
  has_many :spools

  def add_spool(spool)
    spools << spool
    self.save
  end

   def loonth(spool_type)
     found_spools = spools.find(dmc: spool_type)
     lengths = found_spools.map(&:remaining)
     lengths.sum
   end

end


# current_user.inventory.add_spool(Spool.find(dmc: Black))
# current_user.inventory.add_spool(Spool.new(color: Red))
# current_user.inventory.loonth("White")
# => 24
