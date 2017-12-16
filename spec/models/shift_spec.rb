require 'rails_helper'

RSpec.describe Shift, type: :model do
  let(:org) { FactoryGirl.create :organization }
  let(:venue) { FactoryGirl.create :venue }
  let(:bad_shift_no_show) { FactoryGirl.build :shift, show_id: nil }
  let(:user) { FactoryGirl.create :user}
  let(:job) { FactoryGirl.create :job, venue: venue }
  let(:shift) { FactoryGirl.build :shift, job: job }
  describe 'validations' do
    xit 'in invalid without an associated show' do
      expect(bad_shift_no_show).to_not be_valid
    end
    xit 'is valid with an associated show' do
      expect(shift).to be_valid
    end
    it {is_expected.to validate_uniqueness_of(:user_id).scoped_to(:show_id)}
    xdescribe '#authorized?' do
      before(:each) do
        shift.user = user
      end
      it 'is valid when the user is associated with a job' do
        user.jobs << job
        expect(shift).to be_valid
      end
      it 'is invalid when the user is not associated with a job' do
        expect(shift).to_not be_valid
      end
    end
  end
  describe '#remove_worker' do
    let!(:user2) { FactoryGirl.create(:user, jobs: [job]) }
    let(:show_tomorrow) { FactoryGirl.create :show, start: DateTime.tomorrow, venue: venue, info: venue.hooks + 'asdf', organization: org }
    let(:admin) { FactoryGirl.create(:user, organizations: [show_tomorrow.organization]) }
    let(:scheduled_shift) { FactoryGirl.create(:shift, job: job, user: user2)}
    let(:bad_shift) { FactoryGirl.create(:shift, show: show_tomorrow, job: job, user: user2)}
    it 'removes a worker from a shift' do
      scheduled_shift.remove_worker(user2)
      expect(scheduled_shift.user_id).to be_nil
    end
    it 'responds with a message that the worker cannot be removed if within two days of the show associated with the shift' do
      expect(bad_shift.remove_worker(user2)).to include('You cannot cancel your shift from the app within two days of the show. Contact your show organizer for details.')
    end
    it 'allows an admin to remove a worker regardless of the day' do
      admin.admin = org
      expect(bad_shift.remove_worker(admin)).to eq(true)
    end
  end
end
