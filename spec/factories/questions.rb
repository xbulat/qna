FactoryBot.define do
  factory :question do
    title { "MyString" }
    body { "MyText" }
    user

    trait :invalid do
      title { nil }
    end

    trait :sequence do
      sequence(:title) { |n| "MyTitle#{n}" }
      sequence(:body) { |n| "MyQuestion#{n}" }
    end
  end
end
