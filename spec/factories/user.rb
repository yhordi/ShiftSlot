FactoryGirl.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    organizations {[FactoryGirl.create(:organization)]}
  end
  factory :admin, class: :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    after(:create) do |admin, evaluator|
      admin.assignments << FactoryGirl.create(:admin_assignment)
    end
  end
end
