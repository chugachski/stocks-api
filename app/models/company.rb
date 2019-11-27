class Company < ApplicationRecord
  has_many :years
  has_many :stats_profiles, through: :years
end
