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

    trait :with_files do
      files { [Rack::Test::UploadedFile.new(Rails.root.join('spec/rails_helper.rb'))] }
    end
  end

end