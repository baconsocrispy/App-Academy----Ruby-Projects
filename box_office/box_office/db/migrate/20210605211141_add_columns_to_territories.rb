class AddColumnsToTerritories < ActiveRecord::Migration[5.2]
  def change
    rename_column :territories, :sub_region_id, :continent_id

    add_column :territories, :displayed?, :boolean, null: false
  end
end
