class Person < ApplicationRecord
  validates :first_name, :last_name, presence: true

  has_many :director_films, class_name: 'DirectorFilm', primary_key: :id, foreign_key: :director_id
  has_many :directed_films, through: :director_films, source: :film
end
