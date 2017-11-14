require 'rails_helper'

RSpec.describe User::SessionsController, type: :controller do
  let(:org) { FactoryGirl.create :organization}
  let(:user) { FactoryGirl.create :user, organizations: [org]}
  before :each do
    request.env['devise.mapping'] = Devise.mappings[:user]
    setup_controller_for_warden

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
  describe '#create' do
    it 'responds with a status of 302' do
      post :create, params: {"user"=>{"organization_id"=>org.id, "email"=>user.email, "password"=>user.password, "remember_me"=>"0"}}
      expect(response.status).to eq(302)
    end
    it 'sets the @orgs instance variable' do
      post :create, params: {"user" => {}}
      expect(assigns[:orgs]).to eq(Organization.all)
    end
    it 'if a user has been signed in sets the organization_id in the session'
  end
end
