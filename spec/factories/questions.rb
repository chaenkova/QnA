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

    trait :with_files do
      files { [Rack::Test::UploadedFile.new(Rails.root.join('spec/rails_helper.rb'))] }
    end

    trait :with_reward do
      reward
    end

    trait :created_at_yesterday do
      created_at { Date.yesterday }
    end

    trait :created_at_more_yesterday do
      created_at { Date.today - 2 }
    end
  end

end