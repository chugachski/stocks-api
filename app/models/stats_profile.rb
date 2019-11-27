class StatsProfile < ApplicationRecord
  has_many :years
  has_many :companies, through: :years
end
