class Spool < ActiveRecord::Base
  validates :remaining, presence: true

  LENGTH = 8

  def use(meters)
    remaining - meters
    save!
  end
  
end
