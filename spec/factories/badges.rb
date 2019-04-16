FactoryBot.define do
  factory :badge do
    title { 'Badge' }
    image { Rack::Test::UploadedFile.new(Rails.root.join('README.md'), 'text/plain') }
    question
  end
end
