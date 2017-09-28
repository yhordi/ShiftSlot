FactoryGirl.define do
  factory :venue do
    name { Faker::Company.name }
    location { "#{Faker::Address.city}, #{Faker::Address.state_abbr}" }
    abbreviation { 'yo' }
  end
end
