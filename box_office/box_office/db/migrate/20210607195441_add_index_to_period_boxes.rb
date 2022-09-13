class AddIndexToPeriodBoxes < ActiveRecord::Migration[5.2]
  def change
    add_index :period_boxes, [:sequence, :distributed_territory_id, :period_type], name: 'period_boxes_index', unique: true
  end
end
