class Company < ApplicationRecord
  has_many :years, dependent: :destroy
  has_many :stats_profiles, through: :years, dependent: :destroy
end
