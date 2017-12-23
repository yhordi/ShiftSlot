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
    context 'when the org has admins' do
      let(:admin) { FactoryGirl.create :user, organizations: [org]}
      it 'redirects to root' do
        admin.admin = org
        get :new, params: {org_id: org.id}
        expect(response).to redirect_to root_path
      end
    end
  end
  describe '#create' do
    context 'when passed an organization_id' do
      before(:each) do
        post :create, params: {organization_id: org.id, user: user_attrs}
      end
      it 'creates an assignment' do
        expect(Assignment.last.organization_id).to eq(org.id)
      end
      it 'sets the new user as the admin for the new organization' do
        expect(Assignment.last.admin?).to eq true
      end
      it 'redirects to the organization_path' do
          expect(response).to redirect_to organization_path(org.id)
      end
    end
    context "when no organization_id is passed" do
    before(:each) do
      post :create, params: {user: user_attrs}
    end
      it 'responds with a status of 302' do
        expect(response.status).to eq 302
      end
      it 'redirects to the new_user_assignment_path' do
        expect(response).to redirect_to new_user_assignment_path(User.last)
      end
    end
  end

end
