class Company < ApplicationRecord
  validates :name, :symbol, presence: true, uniqueness: true

  scope :order_by_name, ->(dir) { order(name: dir) }
  scope :order_by_id, ->(dir) { order(id: dir) }

  has_many :stats_profiles, dependent: :destroy
end
