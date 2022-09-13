class AddSubRegionToTerritory < ActiveRecord::Migration[5.2]
  def change
    add_column :territories, :sub_region_id, :integer
  end
end
