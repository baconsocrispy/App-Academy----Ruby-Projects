class ChangeColumnsBoModels < ActiveRecord::Migration[5.2]
  def change
    change_column :gross_boxes, :currency, :string, limit: 3
    change_column :weekend_boxes, :currency, :string, limit: 3
  end
end
