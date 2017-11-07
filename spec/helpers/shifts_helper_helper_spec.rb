require 'rails_helper'
RSpec.describe ShiftsHelper, type: :helper do
  let(:org) { FactoryGirl.create :organization }
  let(:venue) { FactoryGirl.create :venue }
  let(:show) { FactoryGirl.create(:show, start: DateTime.new(2001,1), info: venue.abbreviation, organization: org)}
  let!(:door) { FactoryGirl.create :job, title: 'door', venue: venue}
  let(:sound) { FactoryGirl.create :job, title: 'sound', venue: venue}
  let(:bar) { FactoryGirl.create :job, title: 'bar', venue: venue}
  let!(:user1) { FactoryGirl.create :user, jobs: [door], organizations: [org]}
  let(:user2) { FactoryGirl.create :user, jobs: [sound], organizations: [org]}
  let(:shift1) {FactoryGirl.build :shift, job: door, show: show}
  let(:shift2) {FactoryGirl.build :shift, job: bar, show: show}

  describe '#available_workers' do
    before(:each) do
      user1.preferred_days[1].preferred = true
    end
    it 'returns an array of names of workers who are authorized for the job associated with the given shift and are available to work' do
      expect(available_workers(shift1)).to include(user1.name)
    end
    it 'returns an array of workers that does not include unavailable or unauthorized workers' do
      expect(available_workers(shift1)).to_not include(user2.name)
    end
    it 'returns a message if no workers match the given criteria' do
      expect(available_workers(shift2)).to eq("No workers are available to work that day that are authorized for that job.")
    end
  end
end
