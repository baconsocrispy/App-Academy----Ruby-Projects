class ChangeRegionColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :regions, :master_region?, :is_master_region
  end
end
