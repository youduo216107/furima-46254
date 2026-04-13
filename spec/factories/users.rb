FactoryBot.define do
  factory :user do
    nickname                  { Faker::Internet.username }
    email                     { Faker::Internet.unique.email }
    password                  { 'test1111' }
    password_confirmation     { 'test1111' }
    last_name                 { '山田' }
    first_name                { '隆太郎' }
    last_name_kana            { 'ヤマダ' }
    first_name_kana           { 'リクタロウ' }
    birth_date                { '1990-01-01' }
  end
end
