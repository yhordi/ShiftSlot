require 'rails_helper'
require_relative '../support/response'
RSpec.describe CalendarsController, type: :controller do
  let(:org) { FactoryGirl.create :organization }
  let(:user) { FactoryGirl.create(:user)}
  before(:each) do
    sign_in user
  end
  describe '#sync' do
    describe "on success" do
      let(:resp_double) { double(parsed_response: fake_response)}
      before(:each) do
        allow(HTTParty).to receive(:get).and_return(resp_double)
        get :sync, params: {token: 'HAM', organization_id: org.id, state: {timeMax: "2018-03-06T16:00:00-08:00", timeMin: "2018-02-06T16:00:00-08:00"}}
      end
      it 'responds with a 200' do
        expect(response.status).to eq(200)
      end
      it 'renders the sync template' do
        expect(response).to render_template('calendars/sync')
      end
      it 'assigns @google_shows to a hash containing imported values' do
        expect(assigns[:google_shows][:shows][0][:info]).to include('Band!!!')
      end
      it 'assigns @org' do
        expect(assigns[:org]).to eq(org)
      end
    end
    describe 'on failure' do
      let(:resp_double) { double(parsed_response: fake_response)}
      before(:each) do
        allow(HTTParty).to receive(:get).and_return(resp_double)
      end
      it 'assigns @google_shows with a conflicts key containing conflicting shows' do
        FactoryGirl.create(:show, info: "Vic- Four Lights, Coyote Bred, Ol' Doris, The Subjunctives", start: DateTime.parse('2017-10-03T09:00:00-07:00'), organization: org)
        get :sync, params: {token: 'HAM', organization_id: org.id, state: {timeMax: "2018-03-06T16:00:00-08:00", timeMin: "2018-02-06T16:00:00-08:00"}}
        expect(assigns[:google_shows][:conflicts][0][:info]).to include('Four Lights')
      end
    end

  end


end
