class ChangeTerritoryColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :territories, :displayed?, :is_displayed
  end
end
