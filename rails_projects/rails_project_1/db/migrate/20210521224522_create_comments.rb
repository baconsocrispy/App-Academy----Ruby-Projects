class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.integer :user_id, null: false
      t.integer :artwork_id, null: false
      t.text :body, null: false

      t.index :user_id
      t.index :artwork_id
    end
  end
end
