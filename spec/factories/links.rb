FactoryBot.define do
  factory :link do
    name { "link" }
    url { "https://google.com" }
    linkable { create(:question) }

    trait :gist do
      url { 'https://gist.github.com/schacon/1' }
    end

  end
end
