class AddColumnDtidToDGrossBoxes < ActiveRecord::Migration[5.2]
  def change
    add_column :gross_boxes, :distributed_territory_id, :integer, null: false
  end
end
