class GrossBox < ApplicationRecord
  validates :distributed_territory_id, presence: true
  # Add string limit/inclusion to currency validation
  validates :currency, presence: true 
  validates_inclusion_of :is_ended, in: [ true, false ]
  monetize :local_currency_cents, with_model_currency: :currency

  belongs_to :distributed_territory
  
  def self.find_by_distributed_territory_id(distributed_territory_id)
    box = GrossBox.find_by(distributed_territory_id: distributed_territory_id)
    box ||= 0
  end
  def in_eur
    local_currency.exchange_to("EUR")
  end
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
