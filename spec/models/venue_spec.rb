require 'rails_helper'

RSpec.describe Venue, type: :model do
  context 'validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :location }
  end
  context 'associations' do
    let(:venue) { FactoryGirl.create(:venue)}
    it { is_expected.to have_many :shows }
    it "has many organizations" do
      expect(venue.organizations).to be_an(ActiveRecord::Relation)
    end
  end
  describe '#seed_jobs' do
    it 'seeds a newly created venue with a default job of Volunteer' do
      venue = Venue.create(name: Faker::Lovecraft.location, location: Faker::LordOfTheRings.location)
      expect(venue.jobs).to include(Job.find_by(title: 'volunteer'))
    end
  end
end
