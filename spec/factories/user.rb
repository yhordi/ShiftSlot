FactoryGirl.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    organizations {[FactoryGirl.create(:organization)]}
  end
end
