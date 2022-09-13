class Territory < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :region_id, presence: true
  validates_inclusion_of :is_displayed, in: [ true, false ]
  validates :weekend_start, 
    presence: true,
    inclusion: { in: WEEKDAYS, message: "Weekend must start on a valid weekday" }
  # add inclusion/char limit/message to default currency validation
  validates :default_currency,
    presence: true

  belongs_to :region

  has_many :distributed_territories
  has_many :release_dates, through: :distributed_territories, source: :release_dates
  has_many :gross_boxes, through: :distributed_territories, source: :gross_box 
  has_many :period_boxes, through: :distributed_territories, source: :period_boxes

end
