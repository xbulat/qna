FactoryBot.define do
  factory :question do
    title { "MyString" }
    body { "MyText" }
    user

    trait :invalid do
      title { nil }
    end

    trait :sequence do
      sequence(:title) { |n| "Title#{n}" }
      sequence(:body) { |n| "Question#{n}" }
    end
  end
end
