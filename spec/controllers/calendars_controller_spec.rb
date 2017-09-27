require 'rails_helper'
require_relative '../support/response'
RSpec.describe CalendarsController, type: :controller do
  let(:user) { FactoryGirl.create(:user)}
  before(:each) do
    sign_in user
  end
  describe '#sync' do
    describe "on success" do
      let(:get_sync) {}
      let(:resp_double) { double(parsed_response: fake_response)}
      before(:each) do
        allow(HTTParty).to receive(:get).and_return(resp_double)
        get :sync, params: {token: 'HAM'}
      end
      it 'responds with a 200' do
        expect(response.status).to eq(200)
      end
      it 'renders the sync template' do
        expect(response).to render_template('calendars/sync')
      end
      it 'assigns @google_shows to a hash containing imported values' do
        expect(assigns[:google_shows][:shows][0][:info]).to include('Four Lights')
      end
      it 'assigns @shows' do
        expect(assigns[:shows]).to eq(Show.all)
      end
    end
    describe 'on failure' do
      let(:resp_double) { double(parsed_response: fake_response)}
      before(:each) do
        allow(HTTParty).to receive(:get).and_return(resp_double)
      end
      it 'assigns @google_shows with a conflicts key containing conflicting shows' do
        FactoryGirl.create(:show, info: "Vic- Four Lights, Coyote Bred, Ol' Doris, The Subjunctives", start: DateTime.parse('2017-10-03T09:00:00-07:00'))
        get :sync, params: {token: 'HAM'}
        expect(assigns[:google_shows][:conflicts][0][:info]).to include('Four Lights')
      end
    end

  end

  describe '#create' do
    let(:venue) {FactoryGirl.create(:venue)}
    let(:shows_params) {{"shows"=>{"0"=>{"info"=>"#{venue.abbreviation} Band!!!", "start"=>"2017-08-04 23:30:00 UTC"}}}}
    describe 'on success' do
      it 'responds with a status of 302' do
        post :create, params: shows_params
        expect(response.status).to eq(302)
      end
      it 'saves new shows to the database as parsed from the google response' do
        post :create, params: shows_params
        expect(Show.last.info).to eq(shows_params["shows"]["0"]["info"])
      end
    end
    describe 'on failure' do
      let(:bad_params) {{"shows"=>{"0"=>{"info"=>"#{venue.abbreviation} Band!!!", "start"=>"2017-08-04 23:30:00 UTC"}}}}
      it 'adds errors to flash when no abbreviation is pulled in the show information from google' do
        shows_params['shows']['0']['info'] = ''
        post :create, params: shows_params
        expect(flash[:errors]).to_not be_empty
      end
    end
  end
end
