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
    allow(ENV).to receive(:[]).with('REDIRECT_URI').and_return('http://localhost:3000/redirect')
  end
  describe '/redirect' do
    let(:resp_double) { double(parsed_response: oauth2_response)}
    before(:each) do
      allow(HTTParty).to receive(:post).and_return(resp_double)
    end
    it 'responds with a status of 302' do
      state = {org_id: org.id}.to_json
      get :redirect, params: { state: state }
      expect(response.status).to eq(302)
    end
    it 'sends a token in params' do
      state = {org_id: org.id}.to_json
      expect(get :redirect, params: {state: state}).to redirect_to("http://test.host/organizations/#{org.id}/sync?state%5Borg_id%5D=#{org.id}&token=#{resp_double.parsed_response['access_token']}")
    end
  end
  describe '/callback' do
    it 'redirects to a url based on environment variables' do
      base = "https://accounts.google.com/o/oauth2/v2/auth"
      params = {organization_id: 'org.id', timeMax: "2018-03-06T16:00:00-08:00", timeMin: "2018-02-06T16:00:00-08:00"}
      state = {"organization_id" => params[:organization_id], "timeMin" => params[:timeMin], "timeMax" => params[:timeMax]}.to_json
      data = URI.encode_www_form("client_id" => ENV['CAL_CLIENT_ID'], "redirect_uri" => ENV['REDIRECT_URI'], "response_type" => "code", "state" => state, "scope" => 'https://www.googleapis.com/auth/calendar.readonly')
      expect(get :callback, params: params).to redirect_to("#{base}?#{data}")
    end
    it 'responds with a status of 302' do
      params = {organization_id: 'org.id', timeMax: "2018-03-06T16:00:00-08:00", timeMin: "2018-02-06T16:00:00-08:00"}
      get :callback, params: params
      expect(response.status).to eq(302)
    end
  end
end
