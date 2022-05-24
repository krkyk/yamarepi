FactoryBot.define do
  factory :customer do
    name { Faker::Lorem.characters(number:10) }
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
  end
end