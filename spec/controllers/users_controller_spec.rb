require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }
  before(:each) do
    allow(request.env['warden']).to receive(:authenticate!).and_return(user)
    allow(controller).to receive(:current_user).and_return(user)
  end

  describe '#index' do
    it 'assigns the @users variable' do
      get :index
      expect(assigns(:users)).to all be_a(User)
    end
    it 'responds with a status of 200' do
      get :index
      expect(response.status).to eq(200)
    end
    it 'renders the index page' do
      expect(get :index).to render_template(:index)
    end
  end

  describe '#show' do
    let(:hit_user) { get :show, params: {id: user.id} }
    it 'assigns the @user variable' do
      hit_user
      expect(assigns(:user)).to eq(user)
    end
    it 'responds with a status of 200' do
      hit_user
      expect(response.status).to eq(200)
    end
    it 'renders the user page' do
      expect(hit_user).to render_template(:show)
    end
  end
end
