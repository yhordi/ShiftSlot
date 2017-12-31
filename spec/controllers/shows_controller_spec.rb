require 'rails_helper'

RSpec.describe ShowsController, type: :controller do
  let(:org)  { FactoryGirl.create(:organization)}
  let(:venue) { FactoryGirl.create(:venue) }
  let(:show) { FactoryGirl.create(:show, info: venue.hooks + " adflkj aldfkj  alskdfjoqwiehfcl 918372", organization: org) }
  let(:user) { FactoryGirl.create(:user) }
  let(:show_params) {
    {"utf8"=>"✓",
      "authenticity_token"=>"fpqwjiefpi1jf094hgf",
      "show"=>
        {"headliner"=>
          "Yayerz",
          "date(1i)"=>"2017",
          "date(2i)"=>"1",
          "date(3i)"=>"31",
          "doors(4i)"=>"22",
          "doors(5i)"=>"30",
          "start(4i)"=>"22",
          "start(5i)"=>"31",
          "info"=>"yayayayay",
          "recoup"=>"",
          "payout"=>"",
          "event_link"=>"",
          "tickets_link"=>"",
          "door_price"=>""},
        "venue_id"=>venue.id,
        "commit"=>"Create Show",
    "organization_id"=>"1"}
  }
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
  describe '#new' do
    before(:each) do
      get :new, params: {organization_id: org.id}
    end
    it 'assigns the @org variable' do
      expect(assigns[:org]).to eq(org)
    end
    it 'assigns the @show variable' do
      expect(assigns[:show]).to be_a_new(Show)
    end
    it 'responds with a status of 200' do
      expect(response.status).to eq(200)
    end
    it 'renders the new template' do
      expect(response).to render_template(:new)
    end
  end
  describe '#create' do

    it 'responds with a status of 302' do
      post :create, params: show_params
      expect(response.status).to eq(302)
    end
    it 'increments the number of shows in the database by 1' do
      expect{post :create, params: show_params}.to change{Show.count}.by(1)
    end
    it 'redirects to the show_path' do
      post :create, params: show_params
      expect(response).to redirect_to show_path(Show.last)
    end
  end
  describe '#edit' do
    before(:each) do
      get :edit, params: {id: show.id}
    end
    it 'assigns the @show variable' do
      expect(assigns[:show]).to eq(show)
    end
    it 'renders the edit template' do
      expect(response).to render_template(:edit)
    end
    it 'responds with a status of 200' do
      expect(response.status).to eq(200)
    end
  end
  describe '#update' do
    let(:show_params) {
      {"utf8"=>"✓",
        "authenticity_token"=>"/6Q/LUW+JMZSm6chCIJ4LURMTW9EHohEtzDSwGzIx0ee1ciw==",
        "show"=>
          {"headliner"=>
            'Bent Outta Shape',
            "date(1i)"=>"2017",
            "date(2i)"=>"1",
            "date(3i)"=>"31",
            "doors(4i)"=>"22",
            "doors(5i)"=>"00",
            "start(4i)"=>"22",
            "start(5i)"=>"00",
            "info"=>"yayayayay",
            "recoup"=>"",
            "payout"=>"",
            "event_link"=>"",
            "tickets_link"=>"",
            "door_price"=>""},
          "venue_id"=>show.venue_id,
          "commit"=>"Update Show",
          "id"=>show.id}
    }
    before(:each) do
      put :update, params: show_params
    end
    it 'responds with a status of 302' do
      expect(response.status).to eq(302)
    end
    it 'redirects to the show_path' do
      expect(response).to redirect_to show_path(show)
    end
    it 'updates a record in the database' do
      expect(show.reload.headliner).to eq('Bent Outta Shape')
    end
  end
  describe 'destroy' do
    it 'responds with a status of 302'
    it 'responds with a message in flash'
    it 'removes a show from the database'
  end
  describe '#import' do
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
        post :import, params: shows_params
        expect(response.status).to eq(302)
      end
      it 'saves new shows to the database as parsed from the google response' do
        post :import, params: shows_params
        expect(Show.last.info).to eq(shows_params["shows"]["0"]["info"])
      end
    end
    describe 'on failure' do
      let(:bad_params) {{"shows"=>{"0"=>{"info"=>"", "start"=>"2017-08-04 23:30:00 UTC"}}, organization_id: org.id}}
      it 'adds errors to flash when no abbreviation is pulled in the show information from google' do
        post :import, params: bad_params
        expect(flash[:errors]).to_not be_empty
      end
    end
  end
end
