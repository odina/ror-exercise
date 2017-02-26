FactoryGirl.define do
  factory :user do
    trait :admin do
      is_admin { true }
    end
  end
end
