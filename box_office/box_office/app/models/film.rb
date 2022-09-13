class Film < ApplicationRecord
  # Add uniqueness constraint to title
  validates :title, presence: true

  has_many :distributed_territories, dependent: :destroy
  has_many :director_films, dependent: :destroy
  has_many :directors, through: :director_films, source: :director
  has_many :distributors, through: :distributed_territories, source: :distributor
  has_many :release_dates, through: :distributed_territories, source: :release_dates
  has_many :gross_boxes, through: :distributed_territories, source: :gross_box
  has_many :period_boxes, through: :distributed_territories, source: :period_boxes
  

  def director
    self.directors
  end
  def us_distributor
    usa = self.distributed_territories.where(territory_id: 1)
    usa.first.distributor
  end
  # Can't get gross until all currency conversions are available || Check Fixer.io gem
  def gross_box_in_usd
    
  end
  def current_weekends
    self.distributed_territories.each do |terr|
      
    end
  end
  def territory_gross(territory_id)
     dt = distributed_territories.find_by(territory_id: territory_id, film_id: id )
     dt.gross_box
  end
  # This needs to be faster
  def gross_box_in_eur
    gross = gross_boxes.inject(Money.from_amount(0, "EUR")) { |sum, box| sum + box.in_eur }
  end
  def list_grosses
    gross_boxes.each do |gross|
      puts [ gross.territory.name, gross.in_eur ]
    end
  end
end
