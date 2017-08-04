FactoryGirl.define do
  factory :job do
    title { Faker::Job.title }
  end
end
