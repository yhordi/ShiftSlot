require 'rails_helper'

RSpec.describe Shift, type: :model do
  let(:venue) { FactoryGirl.create :venue }
  let(:bad_shift_no_show) { FactoryGirl.build :shift, show_id: nil}
  let(:user) { FactoryGirl.create :user }
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
    describe '#authorized?' do
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
end
