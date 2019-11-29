class StatsProfile < ApplicationRecord
  has_many :years, dependent: :destroy
  has_many :companies, through: :years
end
