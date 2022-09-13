class AddColumnsToRegion < ActiveRecord::Migration[5.2]
  def change
    add_column :regions, :display_region_id, :integer
    add_column :regions, :master_region?, :boolean, null: false
    add_column :regions, :display_priority, :integer
  end
end
