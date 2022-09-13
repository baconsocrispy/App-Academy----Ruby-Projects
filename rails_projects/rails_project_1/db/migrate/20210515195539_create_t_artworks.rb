class CreateTArtworks < ActiveRecord::Migration[5.2]
  def change
    create_table :artworks do |t|
      t.string :title
      t.string :image_url
      t.integer :artist_id

      t.timestamps
    end
  end
end
