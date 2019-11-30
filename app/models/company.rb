class Company < ApplicationRecord
  validates :name, :symbol, presence: true, uniqueness: true

  has_many :years, dependent: :destroy
  has_many :stats_profiles, through: :years, dependent: :destroy
end
