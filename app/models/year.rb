class Year < ApplicationRecord
  validates :year, :company_id, :stats_profile_id, presence: true
  validates :year, uniqueness: { scope: :company_id, message: "can only have one stats profile for a given company and year" }

  belongs_to :company
  belongs_to :stats_profile
end
