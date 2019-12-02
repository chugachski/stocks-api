FactoryBot.define do
  factory :stats_profile do |stats_profile|
    stats_profile.company_id { nil }
    stats_profile.sequence(:year) { |n| 200 + n}
    stats_profile.min { Faker::Number.decimal(l_digits: 2) }
    stats_profile.max { Faker::Number.decimal(l_digits: 2) }
    stats_profile.avg { Faker::Number.decimal(l_digits: 2) }
    stats_profile.ending { Faker::Number.decimal(l_digits: 2) }
    stats_profile.volatility { Faker::Number.between(from: 1, to: 3) }
    stats_profile.annual_change { Faker::Number.between(from: 1, to: 10) }
  end
end
