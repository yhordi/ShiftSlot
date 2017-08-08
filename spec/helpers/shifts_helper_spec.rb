require 'rails_helper'

RSpec.describe ShiftsHelper, type: :helper do
  let!(:show) { FactoryGirl.create(:show) }
  let!(:show_2) { FactoryGirl.create(:show) }
  let!(:unavailable_worker) { FactoryGirl.create(:user) }
  let(:unscheduled_worker) { FactoryGirl.create(:user)}
  let(:scheduled_worker) { FactoryGirl.create(:user)}
  let!(:job) { FactoryGirl.create(:job)}
  let!(:shift) { FactoryGirl.create(:shift, show_id: show.id, user_id: unavailable_worker.id, job_id: job.id) }
  let!(:shift_2) { FactoryGirl.create(:shift, show_id: show_2.id, user_id: scheduled_worker.id, job_id: job.id) }
  describe '#available?' do
    it 'returns true if a user has no shifts scheduled' do
      expect(available?(show, unscheduled_worker.shifts)).to eq(true)
    end
    it 'returns true if a user is schedule for a shift on a day other than the day of the show in question' do
      expect(available?(show, scheduled_worker.shifts)).to eq(true)
    end
    it 'returns false if a user is unavailable on the date of the show in question' do
      expect(available?(show, unavailable_worker.shifts)).to eq(false)
    end
  end
end
