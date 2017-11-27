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
end
