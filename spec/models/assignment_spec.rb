require 'rails_helper'

RSpec.describe Assignment, type: :model do
  let(:org) { FactoryGirl.create :organization }
  let(:user) { FactoryGirl.create :user, organizations: [org]}
  describe 'find_match' do
    it 'returns nil if no match is found' do
      expect(Assignment.find_match(user_id: 1000, organization_id: 10000)).to eq nil
    end
    it 'returns the matching assignment for the given ids' do
      expect(Assignment.find_match(user_id: user.id, organization_id: org.id)).to eq(user.assignments[0])
    end
  end
end
