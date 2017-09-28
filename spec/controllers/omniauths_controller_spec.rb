require 'rails_helper'
require_relative '../support/response'
RSpec.describe OmniauthsController, type: :controller do
  before(:each) do
    allow(ENV).to receive(:[]).with('CAL_CLIENT_ID').and_return('bobobobobo')
    allow(ENV).to receive(:[]).with('CLIENT_SECRET').and_return('Big Dang Secret™')
    allow(ENV).to receive(:[]).with('PROJECT_ID').and_return('Big Dang Project')
  end
  describe '/redirect' do
    let(:resp_double) { double(parsed_response: fake_response)}
    before(:each) do
      allow(HTTParty).to receive(:post).and_return(resp_double)
    end
    it 'responds with a status of 302' do
      get :redirect
      expect(response.status).to eq(302)
    end
    it 'sends a token in params'
  end
  describe '/callback' do

    it 'responds with a status of 302' do
      get :callback
      expect(response.status).to eq(302)
    end
    it 'redirects to a url based on environment variables'
  end
end
