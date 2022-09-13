class AddIndexToReleaseDates < ActiveRecord::Migration[5.2]
  def change
    add_index :release_dates, [ :distributed_territory_id, :release_type], name: 'release_dates_index', unique: true
  end
end
