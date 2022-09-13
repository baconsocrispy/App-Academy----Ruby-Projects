class AddColumnsCreatedAtAndUpdatedAt < ActiveRecord::Migration[5.2]
  def up
    add_column :shortened_urls, :created_at, :datetime
    add_column :shortened_urls, :updated_at, :datetime
  end
  def down
    remove_column :shortened_urls, :created_at
    remove_column :shortened_urls, :updated_at
  end
end
