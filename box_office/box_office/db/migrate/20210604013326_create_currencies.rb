class CreateCurrencies < ActiveRecord::Migration[5.2]
  def change
    create_table :currencies do |t|
      t.string :name, null: false
      t.float :rate_to_USD, null: false
      t.string :currency_code, null: false

      t.timestamps
    end
  end
end
