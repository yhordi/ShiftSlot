require 'rails_helper'
RSpec.describe ShiftsHelper, type: :helper do
  let(:show) { FactoryGirl.create :show, start: DateTime.new(2001,1)}
  let!(:door) { FactoryGirl.create :job, title: 'door'}
  let(:sound) { FactoryGirl.create :job, title: 'sound'}
  let(:bar) { FactoryGirl.create :job, title: 'bar'}
  let!(:user1) { FactoryGirl.create :user, jobs: [door]}
  let(:user2) { FactoryGirl.create :user, jobs: [sound]}
  let(:shift1) {FactoryGirl.build :shift, job: door, show: show}
  let(:shift2) {FactoryGirl.build :shift, job: bar, show: show}

  describe '#available_workers' do
    before(:each) do
      user1.preferred_days[1].preferred = true
    end
    it 'returns an array of workers who are authorized for the job associated with the given shift and are available to work' do
      expect(available_workers(shift1)).to include(user1)
    end
    it 'returns an array of workers that does not include unavailable or unauthorized workers' do
      expect(available_workers(shift1)).to_not include(user2)
    end
    it 'returns a message if no workers match the given criteria' do
      expect(available_workers(shift2)).to eq("No workers are available to work that day, or are authorized for that job")
    end
  end
end
