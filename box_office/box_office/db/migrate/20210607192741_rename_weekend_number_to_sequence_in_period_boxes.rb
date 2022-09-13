class RenameWeekendNumberToSequenceInPeriodBoxes < ActiveRecord::Migration[5.2]
  def change
    rename_column :period_boxes, :weekend_number, :sequence

    add_index :period_boxes, [:sequence, :distributed_territory_id, :period_type], name: 'period_boxes_index', unique: true
  end
end
