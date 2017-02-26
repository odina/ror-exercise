FactoryGirl.define do
  factory :question do
    question { "Hey ho" }

    trait :default do
      is_default { true }
    end
  end
end
