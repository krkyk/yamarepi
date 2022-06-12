FactoryBot.define do
  factory :forum_comment do
    forum_comment { Faker::Lorem.characters(number: 50) }
    customer
  end
end
