FactoryGirl.define do
  factory :authorized_job do
    association :user
    association :job
  end
end
