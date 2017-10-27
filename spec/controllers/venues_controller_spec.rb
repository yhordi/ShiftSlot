require 'rails_helper'

RSpec.describe VenuesController, type: :controller do
  let(:org) { FactoryGirl.create :organization}
  let(:user) { FactoryGirl.create(:user) }
  let(:venue) { FactoryGirl.create(:venue) }
  let(:show) { FactoryGirl.create(:show) }
  before(:each) do
    allow(request.env['warden']).to receive(:authenticate!).and_return(user)
    allow(controller).to receive(:current_user).and_return(user)
  end
  describe '#index' do
    it 'assigns the @venues variable' do
      get :index, params: { organization_id: org.id }
      expect(assigns(:venues)).to be_an(ActiveRecord::Relation)
    end
    it 'responds with a status of 200' do
      get :index, params: { organization_id: org.id }
      expect(response.status).to eq(200)
    end
    it 'renders the index page' do
      expect(get :index, params: { organization_id: org.id }).to render_template(:index)
    end
  end
  describe '#show' do
    it 'assigns the @venue variable' do
      get :show, params: {id: venue.id}
      expect(assigns(:venue)).to eq(venue)
    end
    it 'assigns the @shows variable' do
      get :show, params: {id: venue.id}
      expect(assigns(:shows)).to all(be_a(Show))
    end
    it 'responds with a status of 200' do
      get :show, params: {id: venue.id}
      expect(response.status).to eq(200)
    end
    it 'renders the index page' do
      expect(get :show, params: {id: venue.id}).to render_template(:show)
    end
  end
end
