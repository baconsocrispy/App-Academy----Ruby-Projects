class AddColumnToArtworkShares < ActiveRecord::Migration[5.2]
  def change
    add_column :artwork_shares, :id, :primary_key
  end
end
