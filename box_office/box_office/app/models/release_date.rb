class ReleaseDate < ApplicationRecord
  validates :distributed_territory_id, presence: true
  validates :release_format,
    presence: true,
    inclusion: { in: RELEASE_TYPES, message: "Must be valid release type!" }

  belongs_to :distributed_territory
  
  def film
    distributed_territory.film
  end
  def distributor
    distributed_territory.distributor
  end
  def territory
    distributed_territory.territory
  end
end
