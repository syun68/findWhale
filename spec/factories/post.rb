FactoryBot.define do
  factory :post do
    association :user
    title { Faker::Lorem.characters(number: 10) }
    place_detail { '小笠原　父島' }
    description { Faker::Lorem.characters(number: 10) }

    after(:build) do |post|
      post.image.attach(
        io: File.open('spec/fixtures/post_test_image.jpg'),
        filename: 'post_test_image.jpg'
      )
    end
  end
end
