FactoryBot.define do
  factory :recipe do
    title { Faker::Lorem.characters(number: 5) }
    description { Faker::Lorem.characters(number: 20) }
    serving { Faker::Number.between(to: 3) }
    customer
  end
end
