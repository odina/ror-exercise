FactoryGirl.define do
  factory :answer do
    answer { 'Yes' }

    trait :blank do
      answer { nil }
    end
  end
end
