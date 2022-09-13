class DistributedTerritory < ApplicationRecord
  validates :film_id,
    presence: true,
    uniqueness: { 
      scope: [ :distributor_id, :territory_id ], 
      message: "Distributed Territory already exists in the database!" 
    }
  validates :distributor_id, :territory_id, presence: true

  belongs_to :film
  belongs_to :distributor
  belongs_to :territory

  has_many :release_dates, dependent: :destroy
  has_many :period_boxes, dependent: :destroy
  
  has_one :gross_box, dependent: :destroy
  
end
