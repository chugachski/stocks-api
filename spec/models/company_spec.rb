require 'rails_helper'

RSpec.describe Company, type: :model do
  # associations
  it { should have_many(:stats_profiles).dependent(:destroy) }

  # validations
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:symbol) }
end
