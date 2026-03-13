FactoryBot.define do
  factory :user do
    nickname                  { 'test' }
    email                     { 'test@test.con' }
    password                  { 'test1111' }
    password_confirmation     { 'test1111' }
  end
end
