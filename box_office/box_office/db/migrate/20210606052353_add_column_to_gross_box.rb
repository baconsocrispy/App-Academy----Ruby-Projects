class AddColumnToGrossBox < ActiveRecord::Migration[5.2]
  def change
    add_column :gross_boxes, :is_ended, :boolean, null: false
  end
end
