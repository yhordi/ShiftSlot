require 'rails_helper'
require_relative '../support/response'
RSpec.describe OmniauthsController, type: :controller do
  let(:org) { FactoryGirl.create(:organization) }
  let(:user) { FactoryGirl.create(:user)}
  before(:each) do
    sign_in user
    allow(ENV).to receive(:[]).with('CAL_CLIENT_ID').and_return('bobobobobo')
    allow(ENV).to receive(:[]).with('CLIENT_SECRET').and_return('Big Dang Secret™')
    allow(ENV).to receive(:[]).with('PROJECT_ID').and_return('Big Dang Project')
  end
  describe '/redirect' do
    let(:resp_double) { double(parsed_response: oauth2_response)}
    before(:each) do
      allow(HTTParty).to receive(:post).and_return(resp_double)
    end
    it 'responds with a status of 302' do
      get :redirect, params: {state: org.id}
      expect(response.status).to eq(302)
    end
    it 'sends a token in params' do
      expect(get :redirect, params: {state: org.id}).to redirect_to("http://test.host/organizations/#{org.id}/sync?token=#{resp_double.parsed_response['access_token']}")
    end
  end
  describe '/callback' do
    it 'redirects to a url based on environment variables' do
      expect(get :callback, params: {organization_id: org.id}).to redirect_to("https://accounts.google.com/o/oauth2/v2/auth?client_id=#{ENV['CAL_CLIENT_ID']}&redirect_uri=http%3A%2F%2Flocalhost%3A3000%2Fredirect&response_type=code&state=#{org.id}&scope=https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fcalendar.readonly")
    end
    it 'responds with a status of 302' do
      get :callback, params: {organization_id: org.id}
      expect(response.status).to eq(302)
    end
  end
end
