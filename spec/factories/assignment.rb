FactoryGirl.define do
  factory :assignment do
    association :user
    association :organization
    admin { false }
  end
  factory :admin_assignment, class: :assignment do
    association :user
    association :organization
    admin { true }
  end
end
