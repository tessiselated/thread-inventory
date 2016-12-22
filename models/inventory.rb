class Inventory < ActiveRecord::Base
  belongs_to :user
  has_many :spools


  def separate_length
    whole = self.amount.floor
    point = ((self.amount - whole) * 8).round(1)
    return [whole, point]
  end

  def clean_inventory
  
    binding.pry
  end




end
