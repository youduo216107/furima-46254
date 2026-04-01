FactoryBot.define do
  factory :item do
    after(:build) do |item|
      item.image.attach(io: File.open('public/images/text_image.png'),filename: 'text_image.png')
    end
    name                      { Faker::Commerce.product_name }
    description               { Faker::Lorem.sentence }
    price                     { Faker::Number.between(from: 300, to: 9_999_999) }
    category_id               { Faker::Number.between(from: 1, to: 10) }
    condition_id              { Faker::Number.between(from: 1, to: 6) }
    prefecture_id             { Faker::Number.between(from: 1, to: 47) }
    shipping_fee_id           { Faker::Number.between(from: 1, to: 2) }
    shipping_day_id           { Faker::Number.between(from: 1, to: 3) }
    association :user
  end
end
