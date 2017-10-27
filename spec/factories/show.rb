FactoryGirl.define do
  factory :show do
    doors {Faker::Date.forward}
    start {Faker::Date.forward}
    show_end {Faker::Date.forward}
    info {'yo'}
    association :venue
    association :organization
  end
end
