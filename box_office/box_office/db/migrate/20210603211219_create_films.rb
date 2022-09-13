class CreateFilms < ActiveRecord::Migration[5.2]
  def change
    create_table :films do |t|
      t.string :title, null: false
      t.integer :director_id 
      t.integer :producer_id
      t.integer :cast_id
      t.integer :language_id
      t.integer :country_of_origin_id

      t.timestamps

      t.index :title
      t.index :director_id
      t.index :producer_id
      t.index :language_id
    end
  end
end
