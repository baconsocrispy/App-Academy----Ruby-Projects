class Movie < ApplicationRecord
  belongs_to :director,
    class_name: :Actor,
    foreign_key: :director_id,
    primary_key: :id

  has_many :castings,
    class_name: :Casting,
    foreign_key: :movie_id,
    primary_key: :id

  has_many :actors,
    through: :castings,
    source: :actor

  def self.it_was_ok
  # Consider the following:
  #
  # Movie.where(yr: 1970..1979)
  #
  # We can use ranges (a..b) inside a where method.
  #
  # Find the id, title, and score of all movies with scores between 2 and 3
    self
      .where(score: 2..3)
      .select(:id, :title, :score)
  end
  
end
