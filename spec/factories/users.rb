FactoryBot.define do
  sequence :email do |n|
    "user#{n}@test.com"
  end
  factory :user do
    email
    password {'12345678'}
    password_confirmation{'12345678'}
    confirmed_at { DateTime.now }
  end
end
