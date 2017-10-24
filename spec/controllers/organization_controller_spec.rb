require 'rails_helper'

RSpec.describe OrganizationsController, type: :controller do
  let(:org) { FactoryGirl.create :organization }
  describe '#new' do
    it 'assigns the @org instance variable as a new organization' do
      get :new
      expect(assigns[:org]).to be_a_new(Organization)
    end
  end
  describe '#create' do
    it 'assigns the @org instance variable' do
      post :create, params: {organization: {name: 'PartyTown', gcal_id: '1h5k32bfkii8'}}
      expect(assigns[:org].name).to eq('PartyTown')
    end
    it 'responds with a status of 302' do
    end
      context 'on success' do
        it 'saves an org to the database'
        it 'redirects to the user signup page'
      end
      context 'on fail' do
        it 'sends errors back through a flash message'
        it 'redirects to the new organization page'
      end
  end
end
