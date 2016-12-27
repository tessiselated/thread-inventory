class Inventory < ActiveRecord::Base
  belongs_to :user
  has_many :spools


  def separate_length
    whole = self.amount.floor
    point = ((self.amount - whole) * 8).round(1)
    return [whole, point]
  end

  def check_in_use(spoolid, projects)
    projects.each do |e|
      if e.spool_ids.include? spoolid
        return true
      end
    end
    return false
  end






end
