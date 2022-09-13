class CreateExchangeRates < ActiveRecord::Migration[5.2]
  def change
    create_table :exchange_rates do |t|
      t.date :date_added, null: false
      t.string :base, null: false
      t.string :currency_from, null: false
      t.float :rate, null: false
      t.timestamps
    end
  end
end
