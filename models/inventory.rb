class Inventory < ActiveRecord::Base
  belongs_to :user
  has_many :spools


  def separate_length
    whole = self.amount.floor
    point = ((self.amount - whole) * 8).round(1).to_i
    return [whole, point]
  end

  # def add_spool(spool)
  #   spools << spool
  #   self.save
  # end
  #
  #  def length(spool_type)
  #    found_spools = spools.find(dmc: spool_type)
  #    lengths = found_spools.map(&:remaining)
  #    lengths.sum
  #  end

end


# current_user.inventory.add_spool(Spool.find(dmc: Black))
# current_user.inventory.add_spool(Spool.new(color: Red))
# current_user.inventory.loonth("White")
# => 24
