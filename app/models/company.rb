class Company < ApplicationRecord
  validates :name, :symbol, presence: true, uniqueness: true
  # validates :name, :symbol, presence: { message: "both name and symbol required" }, uniqueness: true

  has_many :stats_profiles, dependent: :destroy
end
