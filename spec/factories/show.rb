FactoryGirl.define do
  factory :show do
    doors {Faker::Date.forward}
    start {Faker::Date.forward}
    show_end {Faker::Date.forward}
    association :venue
  end
end
