FactoryBot.define do
  factory :order_shipping_address do
    postal_code   { Faker::Address.zip_code }
    prefecture_id { Faker::Number.between(from: 1, to: 47)  }
    city          { Faker::Address.city }
    address       { Faker::Address.street_address }
    building      { Faker::Address.building_number }
    phone_number  { Faker::PhoneNumber.cell_phone.gsub('-', '') }
    token         { 'tok_abcdefghijk00000000000000000' }
    user_id       { 1 }
    item_id       { 1 }
  end
end
