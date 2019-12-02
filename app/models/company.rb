class Company < ApplicationRecord
  validates :name, :symbol, presence: true, uniqueness: true

  has_many :stats_profiles
end
