FactoryBot.define do
  factory :company do
    name { Faker::Company.name }
    symbol { Faker::Name.initials(number: 2) }
  end
end
