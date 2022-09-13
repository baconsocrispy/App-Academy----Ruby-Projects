class CreateGrossBoxes < ActiveRecord::Migration[5.2]
  def change
    create_table :gross_boxes do |t|
      t.float :local_currency_gross
      t.integer :admissions
      t.integer :currency_id, null: false

      t.timestamps

      t.index :local_currency_gross
      t.index :admissions
    end
  end
end
