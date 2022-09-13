class Currency < ApplicationRecord
  validates :name, :rate, :code, presence: true
  
  
end