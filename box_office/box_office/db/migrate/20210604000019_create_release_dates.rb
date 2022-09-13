class CreateReleaseDates < ActiveRecord::Migration[5.2]
  def change
    create_table :release_dates do |t|
      t.date :date, null: false
      t.string :type, null: false
      t.integer :distributed_territory_id, null: false
      

      t.timestamps

      t.index :date
    end
  end
end
