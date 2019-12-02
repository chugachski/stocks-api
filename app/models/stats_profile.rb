class StatsProfile < ApplicationRecord
  validates :year, uniqueness: { scope: :company_id, message: "can only be one record for a given company and year" }

  scope :by_year, ->(year) { where(year: year) }
  scope :by_company, ->(company_id) { where(company_id: company_id) }
  scope :by_min, ->(order) { order(min: order) }
  scope :by_max, ->(order) { order(max: order) }
  scope :by_avg, ->(order) { order(avg: order) }
  scope :by_ending, ->(order) { order(ending: order) }
  scope :by_volatility, ->(order) { order(volatility: order) }
  scope :by_annual_change, ->(order) { order(annual_change: order) }

  belongs_to :company
end
