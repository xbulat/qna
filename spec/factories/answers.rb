FactoryBot.define do
  factory :answer do
    body { "MyAnswerText" }
    user

    trait :invalid do
      body { nil }
    end

    trait :valid do
      body { "New Answers" }
    end

    trait :with_question do
      question
    end

    trait :sequence do
      sequence(:body) { |n| "MyAnswerText#{n}" }
    end
  end
end
