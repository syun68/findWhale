FactoryBot.define do
  factory :post do
    association :user
    title { Faker::Lorem.characters(number: 10) }
  end
end
