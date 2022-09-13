class CreateTerritories < ActiveRecord::Migration[5.2]
  def change
    create_table :territories do |t|
      t.string :name, null: false
      t.string :weekend_start, null: false

      t.timestamps
    end
  end
end
