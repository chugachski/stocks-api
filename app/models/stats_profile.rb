class StatsProfile < ApplicationRecord
  include Searchable

  validates :year, presence: true
  validates :year, uniqueness: { scope: :company_id, message: "can only be one record for a given company and year" }

  scope :by_year, ->(year) { where(year: year) }
  scope :by_company, ->(company_id) { where(company_id: company_id) }
  scope :set_order, ->(order_by, order) { order("#{order_by}".to_sym => order) }

  belongs_to :company
end
