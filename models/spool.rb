class Spool < ActiveRecord::Base
  belongs_to :inventory
  belongs_to :shopping_list
  has_and_belongs_to_many :projects
end
