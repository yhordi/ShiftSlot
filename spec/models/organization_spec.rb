require 'rails_helper'

RSpec.describe Organization, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_uniqueness_of :name }
  end
  describe 'associations' do
    let(:org) { FactoryGirl.create :organization }
    it { is_expected.to have_many :venues }
    it { is_expected.to have_many :shows }
    it "has many users" do
      expect(org.users).to be_an(ActiveRecord::Relation)
    end
  end
end
