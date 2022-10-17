FactoryBot.define do
  sequence :answer_body do |n|
    "AnswerB#{n}"
  end

  factory :answer do
    body { generate(:answer_body) }
    question
    user

    trait :invalid do
      body { nil }
      question
      user
    end
  end
end