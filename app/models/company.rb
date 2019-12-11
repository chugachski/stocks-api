class Company < ApplicationRecord
  validates :name, :symbol, presence: true, uniqueness: true

  scope :set_order, ->(order_by, order) { order("#{order_by}".to_sym => order) }

  has_many :stats_profiles, dependent: :destroy
end
