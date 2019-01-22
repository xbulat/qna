FactoryBot.define do
  factory :answer do
    body { "MyText" }
    question { nil }

    trait :invalid do
      body { nil }
    end

    trait :valid do
      body { "New Answers" }
    end
  end
end
