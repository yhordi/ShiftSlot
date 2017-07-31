require 'rails_helper'

RSpec.describe ShowsController, type: :controller do
  let(:venue) { FactoryGirl.create(:venue) }
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
end
