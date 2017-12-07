require 'rails_helper'

RSpec.describe OrganizationsController, type: :controller do
  let(:org) { FactoryGirl.create :organization }
  let(:new_org) { FactoryGirl.attributes_for :organization }
  let(:user) { FactoryGirl.create :user, organizations: [org]}
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
        it 'sends errors back through a flash message' do
          post :create, params: {organization: {name: '', gcal_id: new_org[:gcal_id]}}
          expect(flash[:errors]).to include("Name can't be blank")
        end
        it 'redirects to the new organization page' do
          expect(post :create, params: {organization: {name: '', gcal_id: new_org[:gcal_id]}}).to redirect_to(new_organization_path)
        end
      end
  end
  describe '#show' do
    let!(:admin) {FactoryGirl.create :user, organizations: [org]}
    context 'with a logged in user' do
      before(:each) do
        sign_in admin
      end
      it 'responds with a status of 302' do
        get :show, params: {id: org.id}
        expect(response.status).to eq(302)
      end
      it 'redirects to the organization shows path' do
        expect(get :show, params: {id: org.id}).to redirect_to(organization_shows_path(org))
      end
    end
    context 'with a logged in admin' do
      before(:each) do
        admin.admin = org
        sign_in admin
      end
      it 'when the current user is an admin, assigns the @org instance variable' do
        get :show, params: {id: org.id}
        expect(assigns[:org]).to eq(org)
      end
    end
  end
  describe '#edit' do
    before(:each) do
      sign_in user
      get :edit, params: {id: org.id}
    end
    it 'assigns the @org instance variable' do
      expect(assigns[:org]).to eq org
    end
    it 'renders the edit page' do
      expect(response).to render_template(:edit)
    end
    it 'responds with a status of 200' do
      expect(response.status).to eq(200)
    end
  end
  describe '#update' do
    before(:each) do
      sign_in user
      put :update, params: {organization: {gcal_id: '01493280419823'}, id: org.id}
    end
    it 'assigns the @org instance variable' do
      expect(assigns[:org]).to eq org
    end
    it 'responds with astatus of 302' do
      expect(response.status).to eq(302)
    end
    it 'updates an organization in the database' do
      expect(org.reload.gcal_id).to eq('01493280419823')
    end
    it 'redirects to the organization_path' do
      expect(response).to redirect_to(organization_path(org))
    end
  end
  describe '#destroy' do
    before(:each) do
      sign_in user
    end
    it 'assigns the @org instance variable' do
      delete :destroy, params: {id: org.id}
      expect(assigns[:org]).to eq org
    end
    it 'sets a notice of organization deletion' do
      delete :destroy, params: {id: org.id}
      expect(flash[:notice]).to eq("Organization Deleted")
    end
    it 'removes an organization from the database' do
      delete :destroy, params: {id: org.id}
      expect{Organization.find(org.id)}.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
