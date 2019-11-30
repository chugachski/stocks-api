class StatsProfile < ApplicationRecord
  validates :min, :max, :avg, :volatility, :annual_change, presence: true

  has_many :years, dependent: :destroy
  has_many :companies, through: :years
end
