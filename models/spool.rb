class Spool < ActiveRecord::Base
  belongs_to :inventory
  belongs_to :shopping_list
  belongs_to :project
end
