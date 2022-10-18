FactoryBot.define do
  sequence :title do |n|
    "TitleQ#{n}"
  end
  sequence :body do |n|
    "BodyQ#{n}"
  end

  factory :question do
    title
    body
    user

    trait :invalid do
      title { nil }
    end
  end
end