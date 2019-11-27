class Year < ApplicationRecord
  belongs_to :company
  belongs_to :statistics_profile
end
