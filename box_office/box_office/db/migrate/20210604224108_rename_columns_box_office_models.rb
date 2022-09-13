class RenameColumnsBoxOfficeModels < ActiveRecord::Migration[5.2]
  def change
    rename_column :gross_boxes, :local_currency_gross, :local_cents
    rename_column :weekend_boxes, :local_currency_gross, :local_cents
  end
end
