class RenameColumnsExchangeRate < ActiveRecord::Migration[5.2]
  def change
    rename_column :exchange_rates, :base, :iso_to
    rename_column :exchange_rates, :currency_from, :iso_from
  end
end
