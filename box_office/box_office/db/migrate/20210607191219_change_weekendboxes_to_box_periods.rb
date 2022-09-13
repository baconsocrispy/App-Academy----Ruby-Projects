class ChangeWeekendboxesToBoxPeriods < ActiveRecord::Migration[5.2]
  def change
    rename_table :weekend_boxes, :period_boxes

    add_column :period_boxes, :period_type, :string, null: false
  end
end
