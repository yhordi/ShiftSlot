require 'rails_helper'

RSpec.describe AssignmentsController, type: :controller do
  let(:user) { FactoryGirl.create :user }
  let(:org) { FactoryGirl.create :organization }
  before(:each) do
    sign_in user
  end
  describe 'new' do
    before(:each) do
      get :new, params: {user_id: user.id}
    end
    it 'assigns the @user variable' do
      expect(assigns[:user]).to eq user
    end
    it 'assigns the @orgs variable' do
      expect(assigns[:orgs]).to include(org)
    end
    it 'responds with a status of 200' do
      expect(response.status).to eq 200
    end
    it 'renders the new view' do
      expect(response).to render_template(:new)
    end
  end

  describe 'create' do
    it 'assigns the @org variable' do
      post :create, params: {user_id: user.id, organization_id: org.id}
      expect(assigns[:org]).to eq org
    end
    it 'responds with a 302' do
      post :create, params: {user_id: user.id, organization_id: org.id}
      expect(response.status).to eq 302
    end
    context 'on success' do
      it 'sends a success message through flash' do
        post :create, params: {user_id: user.id, organization_id: org.id}
        expect(flash[:notice]).to eq "You're signed up for #{org.name}"
      end
      it 'redirects to root' do
        post :create, params: {user_id: user.id, organization_id: org.id}
        expect(response).to redirect_to root_path
      end
      it 'creates a new assignment' do
        post :create, params: {user_id: user.id, organization_id: org.id}
        expect(user.reload.organizations).to include(org)
      end
    end
    context 'on failure' do
      it 'responds with an error message'
      it 'redirects to the previous page'
    end
  end

  describe '#update' do
    let(:assignment) { FactoryGirl.create(:assignment)}
    it 'responds with a status of 200' do
      put :update, params: {id: assignment.id}
      expect(response.status).to eq 200
    end
    it 'sets an assignments authorized field to true' do
      put :update, params: {id: assignment.id}
      expect(assignment.reload.authorized?).to eq true
    end
    it 'renders the assignment as json' do
      put :update, params: {id: assignment.id}
      expect(JSON.parse(response.body)["assignment"]["authorized"]).to eq true
    end
  end
end
