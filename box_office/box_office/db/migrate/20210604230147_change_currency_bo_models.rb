class ChangeCurrencyBoModels < ActiveRecord::Migration[5.2]
  def change
    rename_column :gross_boxes, :currency_id, :currency
    rename_column :gross_boxes, :local_cents, :local_currency_cents
    rename_column :weekend_boxes, :currency_id, :currency
    rename_column :weekend_boxes, :local_cents, :local_currency_cents
  end
end
