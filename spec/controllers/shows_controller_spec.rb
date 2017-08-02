require 'rails_helper'

RSpec.describe ShowsController, type: :controller do
  let(:venue) { FactoryGirl.create(:venue) }
  let(:show) { FactoryGirl.create(:show) }
  let(:user) { FactoryGirl.create(:user) }
  before(:each) do
    allow(request.env['warden']).to receive(:authenticate!).and_return(user)
    allow(controller).to receive(:current_user).and_return(user)
  end
  describe '#index' do
    it 'assigns the @shows variable' do
      get :index, params: {venue_id: venue.id}
      expect(assigns(:shows)).to be_an(ActiveRecord::Relation)
    end
    it 'responds with a status of 200' do
      get :index, params: {venue_id: venue.id}
      expect(response.status).to eq(200)
    end
    it 'renders the index page' do
      expect(get :index, params: {venue_id: venue.id}).to render_template(:index)
    end
  end
  describe '#show' do
    let(:hit_show) { get :show, params: {venue_id: show.venue_id, id: show.id} }
    it 'assigns the @show variable' do
      hit_show
      expect(assigns(:show)).to eq(show)
    end
    it 'responds with a status of 200' do
      hit_show
      expect(response.status).to eq(200)
    end
    it 'renders the show page' do
      expect(hit_show).to render_template(:show)
    end
  end
end
