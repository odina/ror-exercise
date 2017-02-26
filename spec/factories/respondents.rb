FactoryGirl.define do
  factory :respondent do
    name { 'John Doe' }

    trait :no_name do
      name { nil }
    end
  end
end
