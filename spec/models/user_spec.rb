require 'rails_helper'

RSpec.describe User, type: :model do
  let(:venue) { FactoryGirl.create :venue}
  let(:user) {FactoryGirl.create :user}
  let(:new_user) {FactoryGirl.build :user}
  let(:job) {FactoryGirl.create :job, venue: venue}
  let(:job2) {FactoryGirl.create :job, title: 'Hamster', venue: venue}
  let(:show) {FactoryGirl.create :show, start: DateTime.new(2001,1)}
  let(:show2) {FactoryGirl.create :show, start: DateTime.new(2001,1)}
  let(:shift) {FactoryGirl.create :shift, show_id: show2.id, user_id: user.id, job_id: job.id}

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

  describe '#add_days' do
    it 'automatically sets up a user with seven preferred days after save' do
      new_user.save
      expect(new_user.preferred_days.length).to eq(7)
    end
  end

  describe '#available' do
    it 'returns true if the worker is not currently scheduled' do
      expect(user.available?(show)).to eq(true)
    end
    it 'returns true if the worker is willing to work the day of the week of the show' do
      user.preferred_days[1].preferred = true
      expect(user.available?(show)).to eq(true)
    end
    it 'returns false if the worker prefers to not work the day of the show' do
      user.preferred_days[1].preferred = false
      expect(user.available?(show)).to eq(false)
    end
    it 'returns false if the worker is scheduled to work on the day of the show' do
      user.jobs << job
      shift
      expect(user.available?(show)).to eq(false)
    end
  end

  describe '#venues' do
    it 'returns an array of venue objects associated with the jobs for the user' do
      user.jobs << job
      expect(user.venues).to eq([job.venue])
    end

    it 'returns an array with no duplicate venues' do
      user.jobs << job
      user.jobs << job2
      expect(user.venues).to eq([job.venue])
    end
  end
end
