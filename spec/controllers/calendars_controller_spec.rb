require 'rails_helper'
require_relative '../support/response'
RSpec.describe CalendarsController, type: :controller do
  let(:user) { FactoryGirl.create(:user)}
  describe '#sync' do
    let(:get_sync) {}
    let(:resp_double) { double(parsed_response: fake_response)}
    before(:each) do
      sign_in user
      allow(HTTParty).to receive(:get).and_return(resp_double)
    end
    it 'responds with a 200' do
      get :sync, params: {token: 'HAM'}
      expect(response.status).to eq(200)
    end
    it 'renders the sync template' do
      get :sync, params: {token: 'HAM'}
      expect(response).to render_template('calendars/sync')
    end
    it 'assigns @google_shows' do
      get :sync, params: {token: 'HAM'}
      expect(assigns[:google_shows][:shows][0][:info]).to include('Four Lights')
    end
    it 'assigns @shows' do
      get :sync, params: {token: 'HAM'}
      expect(assigns[:shows]).to eq(Show.all)
    end
  end

  describe '#create' do
    it 'saves new shows to the database as parsed from the google response'
    it 'responds with a status of 302'
  end
end
