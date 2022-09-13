class PeriodBox < ApplicationRecord
  validates :distributed_territory_id, :start_date, :end_date, presence: true
  validates :sequence,
    uniqueness: { 
      scope: [ :distributed_territory_id, :period_type ], 
      message: "Matching Type and Sequence already exists in the database" 
    },
    presence: true
  # Add inclusion/char limit/message to :currency validation
  validates :currency, presence: true
  validates :period_type,
    inclusion: { in: [ WEEKDAYS, 'Weekend', 'Week'] },
    presence: true

  monetize :local_currency_cents, with_model_currency: :currency

  belongs_to :distributed_territory
  
  def self.find_by_distributed_territory(distributed_territory)
    PeriodBox.where(distributed_territory_id: distributed_territory.id)
  end
  # return LC in USD
  # def in_usd
  #   local_currency.exchange_to("USD")
  # end
  # return LC in Euros
  def in_eur
    local_currency.exchange_to("EUR")
  end
  def region
    territory.region
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
