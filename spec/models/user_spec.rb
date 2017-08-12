require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) {FactoryGirl.create :user}
  let(:job) {FactoryGirl.create :job}
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
end
