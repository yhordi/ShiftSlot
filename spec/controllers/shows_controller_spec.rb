require 'rails_helper'

RSpec.describe ShowsController, type: :controller do
  let(:org)  { FactoryGirl.create(:organization)}
  let(:venue) { FactoryGirl.create(:venue) }
  let(:show) { FactoryGirl.create(:show, info: venue.hooks + " adflkj aldfkj  alskdfjoqwiehfcl 918372", organization: org) }
  let(:user) { FactoryGirl.create(:user) }
  before(:each) do
    allow(request.env['warden']).to receive(:authenticate!).and_return(user)
    allow(controller).to receive(:current_user).and_return(user)
  end
  describe '#index' do
    it 'assigns the @shows variable' do
      get :index, params: {venue_id: venue.id, organization_id: org.id}
      expect(assigns(:shows)).to be_an(ActiveRecord::Relation)
    end
    it 'responds with a status of 200' do
      get :index, params: {venue_id: venue.id, organization_id: org.id}
      expect(response.status).to eq(200)
    end
    it 'renders the index page' do
      expect(get :index, params: {venue_id: venue.id, organization_id: org.id}).to render_template(:index)
    end
  end
  describe '#show' do
    let(:hit_show) { get :show, params: {venue_id: show.venue_id, id: show.id, organization_id: org.id} }
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
  xdescribe '#import' do
    let(:venue) {FactoryGirl.create(:venue, organizations: [org])}
    let(:shows_params) {
      {
        "shows"=> {
          "0"=> {
            "info"=>"#{venue.hooks} Band!!!", "start"=>"2017-08-04 23:30:00 UTC"
          }
        },
        organization_id: org.id

      }
    }
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
      let(:bad_params) {{"shows"=>{"0"=>{"info"=>"", "start"=>"2017-08-04 23:30:00 UTC"}}, organization_id: org.id}}
      it 'adds errors to flash when no abbreviation is pulled in the show information from google' do
        # shows_params['shows']['0']['info'] = ''
        post :create, params: bad_params
        expect(flash[:errors]).to_not be_empty
      end
    end
  end
end
