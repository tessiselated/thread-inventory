class CreateInventory < ActiveRecord::Migration[5.0]
  def change
    create_table :inventories do |t|
      t.string :dmc
      t.string :amount
      t.boolean :required
      t.boolean :in_use
      t.belongs_to :user
    end
  end
end
