class CreateWeekendBoxes < ActiveRecord::Migration[5.2]
  def change
    create_table :weekend_boxes do |t|
      t.integer :distributed_territory_id, null: false
      t.integer :weekend_number, null: false
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.integer :currency_id, null: false
      t.float :local_currency_gross
      t.integer :admissions
      t.integer :rank
      t.integer :screen_count
      t.integer :location_count

      t.timestamps

      t.index :start_date
      t.index :distributed_territory_id
      t.index :weekend_number
      t.index :local_currency_gross
      t.index :admissions
      t.index :screen_count
      t.index :location_count
    end
  end
end
