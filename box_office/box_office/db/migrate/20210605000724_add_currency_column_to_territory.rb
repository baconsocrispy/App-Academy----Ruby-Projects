class AddCurrencyColumnToTerritory < ActiveRecord::Migration[5.2]
  def change
    add_column :territories, :default_currency, :string, limit: 3, null: false
  end
end
