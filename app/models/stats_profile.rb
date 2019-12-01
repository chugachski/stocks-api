class StatsProfile < ApplicationRecord
  include Searchable

  validates :min, :max, :avg, :volatility, :annual_change, presence: true

  # Year.where(year: "2018")
  # Company.where(symbol: "HD")

  scope :by_ids, ->(ids) { where("id IN (?)", ids) }
  scope :by_volatility, ->(dir) { order(volatility: dir) }
  scope :by_annual_change, ->(dir) { order(annual_change: dir) }
  scope :by_min, ->(dir) { order(min: dir) }
  scope :by_max, ->(dir) { order(max: dir) }
  scope :by_avg, ->(dir) { order(avg: dir) }

  has_many :years, dependent: :destroy
  has_many :companies, through: :years
end
