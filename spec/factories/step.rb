FactoryBot.define do
  factory :step do
    step_description { Faker::Lorem.characters(number: 20) }
    recipe
  end
end