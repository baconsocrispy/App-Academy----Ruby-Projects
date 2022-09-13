class Distributor < ApplicationRecord
  validates :name, presence: true

  has_many :distributed_territories
  has_many :films, through: :distributed_territories, source: :film
  has_many :release_dates, through: :distributed_territories, source: :release_dates
  has_many :gross_boxes, through: :distributed_territories, source: :gross_box
  has_many :period_boxes, through: :distributed_territories, source: :period_boxes


end
