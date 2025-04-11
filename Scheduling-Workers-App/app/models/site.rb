class Site < ApplicationRecord

  validates :nome, presence: true
  validates :time_required, presence: true, numericality: {greater_than: 0}
  validates :location, presence: true

  has_many :jobs
  
end
