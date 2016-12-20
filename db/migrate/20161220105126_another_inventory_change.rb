class AnotherInventoryChange < ActiveRecord::Migration[5.0]
  def change
    change_column :inventories, :amount, 'decimal USING CAST(amount AS decimal)'
  end
end
