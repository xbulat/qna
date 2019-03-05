FactoryBot.define do
  factory :answer do
    body { "MyAnswerText" }
    user

    trait :invalid do
      body { nil }
    end

    trait :best do
      best { true }
    end

    trait :valid do
      body { "New Answers" }
    end

    trait :with_question do
      question
    end

    trait :with_file do
      files { Rack::Test::UploadedFile.new(Rails.root.join('README.md'), 'text/plain') }
    end

    trait :sequence do
      sequence(:body) { |n| "MyAnswerText#{n}" }
    end
  end
end
