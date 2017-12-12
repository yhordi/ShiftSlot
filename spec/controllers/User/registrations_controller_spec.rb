require 'rails_helper'

RSpec.describe User::RegistrationsController, type: :controller do
  let(:org) { FactoryGirl.create :organization}
  let(:user_attrs) { FactoryGirl.attributes_for :user }
  before :each do
    request.env['devise.mapping'] = Devise.mappings[:user]
  end
  describe '#new' do
    it 'assigns the @org variable when passed an org_id in params' do
      get :new, params: {org_id: org.id}
      expect(assigns(:org)).to eq(org)
    end
  end
  describe '#create' do
    context 'when passed an organization_id' do
      it 'creates an assignment'
      it 'sets the new user as the admin for the new organization'
      it 'redirects to the organization_path'
    end
    it 'responds with a status of 302' do
      post :create, params: {user: user_attrs}
      expect(response.status).to eq 302
    end
    it 'redirects to the new_user_assignment_path' do
      post :create, params: {user: user_attrs}
      expect(response).to redirect_to new_user_assignment_path(User.last)
    end
  end

end
