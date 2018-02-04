require 'rails_helper'

RSpec.describe Assignment, type: :model do
  let(:org) { FactoryGirl.create :organization }
  let(:user) { FactoryGirl.create :user, organizations: [org]}
  describe 'validations' do
    let(:user2) { FactoryGirl.create :user }
    it 'validates a unique record' do
      assignment = Assignment.new(user: user2, organization: org)
      expect(assignment).to be_valid
    end
    it 'does not validate an assignment that matches an existing assignment' do
      assignment = Assignment.new(user: user, organization: org)
      expect(assignment).to_not be_valid
    end
  end
  describe 'find_match' do
    it 'returns nil if no match is found' do
      expect(Assignment.find_match(user_id: 1000, organization_id: 10000)).to eq nil
    end
    it 'returns the matching assignment for the given ids' do
      expect(Assignment.find_match(user_id: user.id, organization_id: org.id)).to eq(user.assignments[0])
    end
  end
  describe '.create_and_authorize' do
    it 'creates an assignment that is also authorized' do
      assign = Assignment.create_and_authorize(user_id: user.id, organization_id: org.id)
      expect(assign.authorized?).to eq true
    end
  end
end
