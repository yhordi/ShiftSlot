require_relative '../support/response'

RSpec.describe Show, type: :model do
  let!(:org) { FactoryGirl.create :organization }
  let!(:venue) { FactoryGirl.create :venue, organizations: [org] }
  let(:bad_show) { FactoryGirl.build :show, venue_id: nil}
  let!(:job) { FactoryGirl.create :job, venue: venue}
  let(:show) { FactoryGirl.create :show, venue: venue, info: venue.hooks, organization: org }
  let!(:user) { FactoryGirl.create :user}

  describe 'validations' do
    it { is_expected.to validate_presence_of :info }
    it { is_expected.to validate_presence_of :date }
    it { is_expected.to validate_presence_of :start }
    it { is_expected.to validate_presence_of(:venue_id).with_message("ShiftSlot couldn't infer what venue this show is being booked at. Either add a hook to your venue in the app, or put the venue name in the google calendar event") }
  end

  describe '#readable' do
    it 'responds with the time formatted HH:MMam/pm' do
      expect(show.readable(show.start)).to eq(show.start.strftime('%I:%M%p'))
    end
  end

  describe '#format_dates' do
    let(:params) {
      {"utf8"=>"✓",
       "authenticity_token"=>"MLJBJQdLumvzOYaoRjAtt7NC1G5HwkvtMATM9aGDt+rNFxoGZFIxKEkbWeuS1cEZQU5zr/KApkXnZbaNJ5Sokw==",
       "show"=>
        {"headliner"=>"afafafaf",
         "date(1i)"=>"2017",
         "date(2i)"=>"12",
         "date(3i)"=>"30",
         "doors(4i)"=>"18",
         "doors(5i)"=>"00",
         "start(4i)"=>"23",
         "start(5i)"=>"30",
         "info"=>"yayuh",
         "recoup"=>"",
         "payout"=>"",
         "event_link"=>"",
         "tickets_link"=>"",
         "door_price"=>""},
       "venue_id"=>"2",
       "commit"=>"Create Show",
       "organization_id"=>"1"}
    }
    it 'sets the doors field based on passed in times' do
      dates = show.format_dates(['doors', 'start'], params)
      expect(show.doors).to eq(dates[0])
    end
    it 'sets the start field based on passed in times' do
      dates = show.format_dates(['doors', 'start'], params)
      expect(show.start).to eq(dates[1])
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

  describe '#assign_venue' do
    let(:parsed_show) {FactoryGirl.build :show, venue: nil, info: venue.name + ' asdflkajsdflkjasdlfk', organization: org}
    let(:hook_show) {FactoryGirl.build :show, venue: nil, info: venue.parsed_hooks[0] + ' as524343dflkajsdflkjasdlfk', organization: org}
    it 'assigns the associated venue based on the info field containing the name of the venue' do
      parsed_show.assign_venue
      expect(parsed_show.venue).to eq(venue)
    end
    it 'assigns the associated venue based on the info field containing the one of the hooks of the venue' do
      hook_show.assign_venue
      expect(hook_show.venue).to eq(venue)
    end
  end

end
