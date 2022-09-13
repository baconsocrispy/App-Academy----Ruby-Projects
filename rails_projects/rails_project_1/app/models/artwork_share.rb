class ArtworkShare < ApplicationRecord
  validates :viewer_id, presence: true, uniqueness: { scope: :artwork_id, message: 'Artwork cannot be unseen'}
  validates :artwork_id, presence: true

  belongs_to :viewer, class_name: 'User', foreign_key: :viewer_id, primary_key: :id
  belongs_to :artworks, class_name: 'Artwork', foreign_key: :artwork_id, primary_key: :id
end