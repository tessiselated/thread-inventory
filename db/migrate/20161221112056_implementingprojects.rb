class Implementingprojects < ActiveRecord::Migration[5.0]
  def change

    create_table :projects do |t|
      t.string :name
      t.belongs_to :user
    end



    create_table :projects_spools do |t|
      t.belongs_to :project
      t.references :spool
    end

  end
end
