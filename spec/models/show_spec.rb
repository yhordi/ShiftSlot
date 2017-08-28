RSpec.describe Show, type: :model do
  let(:venue) { FactoryGirl.create :venue }
  let(:bad_show) { FactoryGirl.build :show, venue_id: nil}
  let!(:job) { FactoryGirl.create :job, venue: venue}
  let(:show) { FactoryGirl.create :show, venue: venue}
  let!(:user) { FactoryGirl.create :user}

  describe 'validations' do
    it { is_expected.to validate_presence_of :start }
    describe 'validates_associated :venue' do
      it 'in invalid without an associated venue' do
        expect(bad_show).to_not be_valid
      end
      it 'is valid with an associated venue' do
        expect(show).to be_valid
      end
    end
  end

  describe '#date' do
    it 'responds with just the date portion from the start field' do
      expect(show.date).to eq(show.start.strftime('%A, %D'))
    end
  end

  describe '#readable' do
    it 'responds with the time formatted HH:MMam/pm' do
      expect(show.readable(show.start)).to eq(show.start.strftime('%I:%M%p'))
    end
  end

  describe '#staffed?' do
    it 'returns false when there are no shifts scheduled' do
      expect(show.staffed?).to eq(false)
    end
    it 'returns false when there are shifts scheduled, but no users signed up to work them' do
      show.shifts << Shift.create(job: job)
      expect(show.staffed?).to eq(false)

    end
    it 'returns false when there are shifts scheduled, and users signed up, but not for all shifts' do
      show.shifts << Shift.create(job: job)
      show.shifts << Shift.create(job: job, user_id: user.id)
      expect(show.staffed?).to eq(false)
    end
    it 'returns true when there are users signed up for every shift' do
      show.shifts << Shift.create(job: job, user_id: user.id)
      expect(show.staffed?).to eq(true)
    end
  end

  describe 'Show.available_shifts_for' do
    let!(:job2) { FactoryGirl.create :job, venue: venue, title: 'Coat Check' }
    let!(:shift) { FactoryGirl.create :shift, show: show, job: job2, user_id: nil }
    it 'returns an empty array when no shifts are available' do
      user.jobs << job
      expect(Show.available_shifts_for(user)).to eq([])
    end
    it 'returns an array containing shifts that the user can work' do
      user.jobs << job2
      expect(Show.available_shifts_for(user)).to eq([shift])
    end
  end

end
