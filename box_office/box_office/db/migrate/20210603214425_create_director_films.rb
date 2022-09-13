class CreateDirectorFilms < ActiveRecord::Migration[5.2]
  def change
    create_table :director_films do |t|
      t.integer :director_id, null: false
      t.integer :film_id, null: false

      t.timestamps
    end
  end
end
