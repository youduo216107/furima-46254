FactoryBot.define do
  factory :item do
    after(:build) do |item|
      item.image.attach(io: File.open('public/images/text_image.png'),filename: 'text_image.png')
    end
    name                      { 'test' }
    description               { 'test' }
    price                     { 500 }
    category_id               { 1 }
    condition_id              { 1 }
    prefecture_id             { 1 }
    shipping_fee_id           { 1 }
    shipping_day_id           { 1 }
    association :user
  end
end
