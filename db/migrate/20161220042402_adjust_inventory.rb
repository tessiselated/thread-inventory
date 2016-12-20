class AdjustInventory < ActiveRecord::Migration[5.0]
  def change
    change_table :inventories do |t|
      t.remove :required, :in_use
    end


  end
end
