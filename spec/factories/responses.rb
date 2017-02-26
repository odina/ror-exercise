FactoryGirl.define do
  factory :response do
    respondent { create :respondent }
  end
end
