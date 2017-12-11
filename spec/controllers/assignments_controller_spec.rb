require 'rails_helper'

RSpec.describe AssignmentsController, type: :controller do
  let(:user) { FactoryGirl.create :user }
  let(:org) { FactoryGirl.cretae :organization }
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
      expect(assigns[:user]).to eq user
    end
    it 'responds with a status of 200' do
      expect(response.status).to eq 200
    end
    it 'renders the new view' do
      expect(response).to render_template(:new)
    end
  end

  describe 'create' do
    it 'assigns the @org variable'
    it 'responds with a 302'
    context 'on success' do
      it 'sends a success message through flash'
      it 'redirects to root'
    end
    context 'on failure' do
      it 'responds with an error message'
      it 'redirects to the previous page'
    end
  end
end
