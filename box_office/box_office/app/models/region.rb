class Region < ApplicationRecord
  validates :name, presence: true
  validates_inclusion_of :is_master_region, in: [ true, false ]
  # add validation to make sure display_region_id is valid (matches existing territory)

  has_many :territories

  def get_territory_names
    names = []
    self.territories.each { |terr| names << terr.name }
    names
  end
end
