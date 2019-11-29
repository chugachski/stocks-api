class Year < ApplicationRecord
  belongs_to :company
  belongs_to :stats_profile
end
