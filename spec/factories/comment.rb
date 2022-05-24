FactoryBot.define do
  factory :comment do
    comment { Faker::Lorem.characters(number:10) }
    customer
  end
end