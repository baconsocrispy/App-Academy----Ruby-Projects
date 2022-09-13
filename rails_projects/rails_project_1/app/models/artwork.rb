class Artwork < ApplicationRecord
  validates :title, presence: true, uniqueness: { scope: :artist_id, message: "Artist can't create the same piece twice"}
  validates :image_url, :artist_id, presence: true

  belongs_to :artist, class_name: 'User', foreign_key: 'artist_id', primary_key: 'id'
  has_many :artwork_shares
  has_many :shared_viewers, through: :artwork_shares, source: :viewer
  has_many :comments, dependent: :destroy

  def self.find_by_user(user_id)
    Artwork
      .left_outer_joins(:artwork_shares)
      .where('(artworks.artist_id = :user_id) OR (artwork_shares.viewer_id = :user_id)', user_id: user_id)
      .distinct
  end
end