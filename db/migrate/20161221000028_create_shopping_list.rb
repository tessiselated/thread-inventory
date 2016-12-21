class CreateShoppingList < ActiveRecord::Migration[5.0]
  def change
    create_table :shopping_lists do |t|
      t.belongs_to :user
      t.references :spools
      t.integer :amount
    end
  end
end
