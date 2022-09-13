class CreateArtworkShares < ActiveRecord::Migration[5.2]
  def change
    create_join_table :artworks, :users, table_name: :artworkshares do |t|
      t.index :artwork_id
      t.index :user_id
    end
  end
end
