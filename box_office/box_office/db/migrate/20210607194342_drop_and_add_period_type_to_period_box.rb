class DropAndAddPeriodTypeToPeriodBox < ActiveRecord::Migration[5.2]
  def change
    remove_column :period_boxes, :period_type
    add_column :period_boxes, :period_type, :string, null: false
  end
end
