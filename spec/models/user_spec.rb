require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) {FactoryGirl.create :user}
  let(:new_user) {FactoryGirl.build :user}
  let(:job) {FactoryGirl.create :job}
  # let!(:day) {FactoryGirl.create :preferred_day, user_id: user.id}
  describe 'validations' do
    it { is_expected.to validate_presence_of :email }
    it { is_expected.to validate_length_of(:name).is_at_least(3) }
  end

  describe '#authorized?' do
    it 'returns true if the user is authorized for a job' do
      user.jobs << job
      expect(user.authorized?(job)).to eq(true)
    end
    it 'returns false if the user is not authorized for a job' do
      expect(user.authorized?(job)).to eq(false)
    end

  end
  describe '#adjust_jobs' do
    it 'authorizes a user for jobs based on a passed in array' do
      user.adjust_jobs([job.id.to_s])
      expect(user.jobs).to include(job)
    end
  end

  describe '#day_preferences' do
    it 'constructs a hash of the day preference for the user' do
      expect(user.day_preferences[day.name]).to eq(true)
    end
  end

  describe '#add_days' do
    it 'automatically sets up a user with seven preferred days after save' do
      new_user.save
      expect(new_user.preferred_days.length).to eq(7)
    end
  end
end
