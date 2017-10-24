require 'rails_helper'

RSpec.describe OrganizationsController, type: :controller do
  let(:org) { FactoryGirl.create :organization }
  let(:new_org) { FactoryGirl.attributes_for :organization }
  describe '#new' do
    it 'assigns the @org instance variable as a new organization' do
      get :new
      expect(assigns[:org]).to be_a_new(Organization)
    end
  end
  describe '#create' do
    it 'assigns the @org instance variable' do
      post :create, params: {organization: {name: new_org[:name], gcal_id: new_org[:gcal_id]}}
      expect(assigns[:org].name).to eq(new_org[:name])
    end
    it 'responds with a status of 302' do
      post :create, params: {organization: {name: new_org[:name], gcal_id: new_org[:gcal_id]}}
      expect(response.status).to eq(302)
    end
      context 'on success' do
        it 'saves an org to the database' do
          expect{post :create, params: {organization: {name: new_org[:name], gcal_id: new_org[:gcal_id]}}}.to change{Organization.count}.by(1)
        end
        it 'redirects to the user signup page' do
          expect(post :create, params: {organization: {name: new_org[:name], gcal_id: new_org[:gcal_id]}}).to redirect_to("/users/new?org_id=#{Organization.last.id}")
        end
      end
      context 'on fail' do
        it 'sends errors back through a flash message'
        it 'redirects to the new organization page'
      end
  end
end
