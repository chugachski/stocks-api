require 'rails_helper'

RSpec.describe StatsProfile, type: :model do
  # associations
  it { should belong_to(:company) }

  # validations
  it { should validate_presence_of(:year) }
end
