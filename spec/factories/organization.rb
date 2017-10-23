FactoryGirl.define do
  factory :organization do
    name { Faker::Company.name }
    gcal_id { Faker::Number.number(10) }
  end
end
