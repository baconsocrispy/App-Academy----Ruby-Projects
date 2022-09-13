class RemoveDateAddedColumnFromExchangeRates < ActiveRecord::Migration[5.2]
  def change
    remove_column :exchange_rates, :date_added
  end
end
