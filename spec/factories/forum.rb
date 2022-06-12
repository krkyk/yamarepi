FactoryBot.define do
  factory :forum do
    forum_title { Faker::Lorem.characters(number: 20) }
    forum_content { Faker::Lorem.characters(number: 150) }
    customer
  end
end