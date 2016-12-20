class CreateSpoolTable < ActiveRecord::Migration[5.0]
  def change
    create_table :spools do |t|
      t.string :dmc
      t.string :name
      t.string :rgb
    end
  end
end
