class AddRegionIdToTerritory < ActiveRecord::Migration[5.2]
  def change
    add_column :territories, :region_id, :integer, null: false
  end
end
