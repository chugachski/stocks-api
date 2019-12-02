FactoryBot.define do
  factory :stats_profile do
    company_id { nil }
    year { Faker::Number.within(range: 2000..2018) }
    min { Faker::Number.decimal(l_digits: 2) }
    max { Faker::Number.decimal(l_digits: 2) }
    avg { Faker::Number.decimal(l_digits: 2) }
    ending { Faker::Number.decimal(l_digits: 2) }
    volatility { Faker::Number.between(from: 1, to: 3) }
    annual_change { Faker::Number.between(from: 1, to: 10) }
  end
end
