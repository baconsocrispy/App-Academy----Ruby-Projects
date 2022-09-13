class RemoveColumnsFromFilm < ActiveRecord::Migration[5.2]
  def change
    remove_column :films, :director_id
    remove_column :films, :producer_id
    remove_column :films, :cast_id
    remove_column :films, :language_id
    remove_column :films, :country_of_origin_id
  end
end
