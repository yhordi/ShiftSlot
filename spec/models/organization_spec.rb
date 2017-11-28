require 'rails_helper'

RSpec.describe Organization, type: :model do
  let(:org) { FactoryGirl.create :organization }
  let!(:venue) {FactoryGirl.create :venue, organizations: [org]}
  describe 'validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_uniqueness_of :name }
  end
  describe 'associations' do
    it { is_expected.to have_many :venues }
    it { is_expected.to have_many :shows }
    it "has many users" do
      expect(org.users).to be_an(ActiveRecord::Relation)
    end
  end

  describe 'upcoming_shows' do
    let(:past) { Show.new(doors: Faker::Date.backward) }
    before(:each) do
      4.times do
        show = Show.new(doors: Faker::Date.forward)
        show.organization = org
        show.start = show.doors + 30.minutes
        show.show_end = show.doors + 4.hours
        show.venue_id = venue.id
        show.headliner = Faker::RockBand.name
        show.info = Faker::Lorem.sentence
        show.save!
      end
      past.organization = org
      past.start = past.doors + 30.minutes
      past.show_end = past.doors + 4.hours
      past.venue_id = venue.id
      past.headliner = Faker::RockBand.name
      past.info = Faker::Lorem.sentence
      past.save!
    end
    it 'returns a collection up to 5 shows from today onward' do
      expect(org.upcoming_shows.length).to eq(4)
    end
    it 'does not include shows that are in the past' do
      expect(org.upcoming_shows).to_not include(past)
    end
    it 'when given an integer as anargument changes the length of the returned array' do
      expect(org.upcoming_shows(3).length).to_not eq(5)
    end
  end
  describe '#authorize_volunteer' do
    let(:user) { FactoryGirl.create(:user) }
    let(:job) { FactoryGirl.create(:job, venue: venue)}
    before(:each) do
      org.users << user
    end
    it 'assigns a newly added user the volunteer job for every associated venue' do
      expect(user.jobs).to include(venue.jobs.find_by(title: 'volunteer'))
    end
    it 'does not assign any other jobs associated with the venue' do
      expect(user.jobs).to_not include(job)
    end
  end
end
