require 'rails_helper'

RSpec.describe VenuesController, type: :controller do
  let(:org) { FactoryGirl.create :organization}
  let(:user) { FactoryGirl.create(:user, organizations: [org]) }
  let(:venue) { FactoryGirl.create(:venue) }
  let(:show) { FactoryGirl.create(:show) }
  before(:each) do
    allow(request.env['warden']).to receive(:authenticate!).and_return(user)
    allow(controller).to receive(:current_user).and_return(user)
  end
  describe '#index' do
    it 'assigns the @venues variable' do
      get :index, params: { organization_id: org.id }
      expect(assigns(:venues)).to be_an(ActiveRecord::Relation)
    end
    it 'responds with a status of 200' do
      get :index, params: { organization_id: org.id }
      expect(response.status).to eq(200)
    end
    it 'renders the index page' do
      expect(get :index, params: { organization_id: org.id }).to render_template(:index)
    end
  end
  describe '#show' do
    it 'assigns the @venue variable' do
      get :show, params: {id: venue.id}
      expect(assigns(:venue)).to eq(venue)
    end
    it 'assigns the @shows variable' do
      get :show, params: {id: venue.id}
      expect(assigns(:shows)).to all(be_a(Show))
    end
    it 'responds with a status of 200' do
      get :show, params: {id: venue.id}
      expect(response.status).to eq(200)
    end
    it 'renders the index page' do
      expect(get :show, params: {id: venue.id}).to render_template(:show)
    end
  end
  describe 'new' do
    context 'when the logged in user is an admin' do
      before(:each) do
        user.admin = org
        user.save
        get :new
      end
      it 'assigns the @orgs variable' do
        expect(assigns[:orgs]).to eq(user.all_admin_orgs)
      end
      it 'assigns the @venue variable' do
        expect(assigns[:venue]).to be_a_new(Venue)
      end
      it 'responds with a status of 200' do
        expect(response.status).to eq(200)
      end
      it 'renders the new template' do
        expect(response).to render_template(:new)
      end
    end
    context 'when the logged in user is not an admin' do
      before(:each) do
        get :new
      end
      it 'responds with a status of 302' do
        expect(response.status).to eq(302)
      end
      it 'redirecs to root' do
        expect(response).to redirect_to root_path
      end
    end
  end
  describe 'create' do
    let(:venue_attr) { FactoryGirl.attributes_for :venue }
    it 'responds with a status of 302' do
      post :create, params: { venue: venue_attr, organization_id: org.id }
      expect(response.status).to eq(302)
    end
    context 'on success' do
      it 'increments the venue count in the database by one' do
        expect{post :create, params: { venue: venue_attr, organization_id: org.id }}.to change{Venue.count}.by(1)
      end
      it 'redirects to the organization_venues_path' do
        post :create, params: { venue: venue_attr, organization_id: org.id}
        expect(response).to redirect_to organization_venues_path(org.id)
      end
    end
    context 'on failure' do
      let(:bad_venue_attr) { FactoryGirl.attributes_for :venue, name: '' }
      it 'responds with an error message in flash' do
        post :create, params: { venue: bad_venue_attr, organization_id: org.id}
        expect(flash[:errors]).to include("Name can't be blank")
      end
      it 'redirects to the new_venue_path' do
        post :create, params: { venue: bad_venue_attr, organization_id: org.id}
        expect(response).to redirect_to new_venue_path
      end
    end
  end
end
