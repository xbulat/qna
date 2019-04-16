FactoryBot.define do
  factory :link do
    name { "Google" }
    url { "https://google.com" }

    trait :gist do
      url { "https://gist.github.com/xbulat/83ce41c77955f86eeee9c475783388da" }
    end
  end
end
