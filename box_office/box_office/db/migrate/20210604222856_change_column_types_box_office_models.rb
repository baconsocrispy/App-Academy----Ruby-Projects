class ChangeColumnTypesBoxOfficeModels < ActiveRecord::Migration[5.2]
  def change
    change_column :gross_boxes, :local_currency_gross, :decimal
    change_column :weekend_boxes, :local_currency_gross, :decimal
  end
end
