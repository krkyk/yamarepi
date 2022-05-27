FactoryBot.define do
  factory :ingredient do
    content { Faker::Lorem.characters(number: 5) }
    quantity { Faker::Lorem.characters(number: 2) }
    recipe
  end
end
