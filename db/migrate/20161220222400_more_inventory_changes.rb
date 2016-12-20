class MoreInventoryChanges < ActiveRecord::Migration[5.0]
  def change
    change_table :inventories do |t|
      t.remove :dmc
      t.references :spools
    end
  end
end
