FactoryGirl.define do
  factory :shift do
    association :show
    association :user
  end
end
