class ChangeArtworkSharesColumnNames < ActiveRecord::Migration[5.2]
  def change
    rename_column :artworkshares, :user_id, :viewer_id
  end
end
