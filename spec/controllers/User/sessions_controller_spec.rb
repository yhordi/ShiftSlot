require 'rails_helper'

RSpec.describe User::SessionsController, type: :controller do
  let(:org) { FactoryGirl.create :organization}
  let(:user_attrs) { FactoryGirl.attributes_for :user, organization_id: org.id}
  before :each do
    request.env['devise.mapping'] = Devise.mappings[:user]
  end
  describe '#new' do
    it 'renders a status of 200' do
      get :new
      expect(response.status).to eq(200)
    end
    it 'when passed a param of org_name assigns the @org instance variable' do
      get :new, params: {org_name: org.name}
      expect(assigns[:org]).to eq(org)
    end
    it 'when not passed a param of org_name assigns the @orgs instance variable' do
      get :new
      expect(assigns[:orgs]).to eq(Organization.all)
    end
  end
end
