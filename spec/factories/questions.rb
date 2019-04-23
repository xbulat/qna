FactoryBot.define do
  factory :question do
    title { "MyString" }
    body { "MyText" }
    user

    trait :invalid do
      title { nil }
    end

    trait :with_file do
      files { Rack::Test::UploadedFile.new(Rails.root.join('README.md'), 'text/plain') }
    end

    trait :complete do
    end

    trait :sequence do
      sequence(:title) { |n| "MyTitle#{n}" }
      sequence(:body) { |n| "MyQuestion#{n}" }
    end
  end
end
