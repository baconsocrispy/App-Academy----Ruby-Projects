class DirectorFilm < ApplicationRecord
  validates :director_id, :film_id, presence: true
  
  belongs_to :director, class_name: 'Person', primary_key: :id, foreign_key: :director_id
  belongs_to :film
 
  
end
