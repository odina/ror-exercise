FactoryGirl.define do
  factory :web_survey do
    title { "test" }
    shortlink_slug { "test-#{SecureRandom.hex}" }
  end
end
