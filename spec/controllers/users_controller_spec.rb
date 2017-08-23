require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let!(:venue) { FactoryGirl.create(:venue)}
  let!(:user) { FactoryGirl.create(:user) }
  let!(:job) { FactoryGirl.create(:job, venue: venue) }
  let!(:aut_job) { FactoryGirl.create(:authorized_job, job_id: job.id, user_id: user.id)}
  before(:each) do
    allow(request.env['warden']).to receive(:authenticate!).and_return(user)
    allow(controller).to receive(:current_user).and_return(user)
  end

  describe '#index' do
    it 'assigns the @users variable' do
      get :index
      expect(assigns(:users)).to all be_a(User)
    end
    it 'responds with a status of 200' do
      get :index
      expect(response.status).to eq(200)
    end
    it 'renders the index page' do
      expect(get :index).to render_template(:index)
    end
  end

  describe '#show' do
    let(:hit_user) { get :show, params: {id: user.id} }
    it 'assigns the @user variable' do
      hit_user
      expect(assigns(:user)).to eq(user)
    end
    it 'responds with a status of 200' do
      hit_user
      expect(response.status).to eq(200)
    end
    it 'renders the user page' do
      expect(hit_user).to render_template(:show)
    end
  end

  describe '#edit' do
    let(:hit_user) { get :edit, params: {id: user.id} }
    it 'assigns the @user variable' do
      hit_user
      expect(assigns(:user)).to eq(user)
    end
    it 'responds with a status of 200' do
      hit_user
      expect(response.status).to eq(200)
    end
    it 'renders the edit form' do
      expect(hit_user).to render_template(:edit)
    end
  end

  describe '#update' do
    let(:params) {
       {"utf8"=>"✓",
         "authenticity_token"=>"6q5va/I4MW7HpnRCIDtVxFU0AIoVBPZeC+tyFQsn93ZEDQlbY2kn51/bugeXRwRAENaDryVXajnhOt9KswqDAw==",
          "user"=>{"admin"=>"1"},
          "job_ids"=>[job.id.to_s],
          "commit"=>"Update User",
          "id"=>user.id}
    }
    let(:hit_update) { patch :update, params: params}
    it 'updates the user in the database' do
      hit_update
      expect(user.reload.admin).to eq(true)
    end
    it 'assigns the @user variable' do
      hit_update
      expect(assigns[:user]).to eq(user)
    end
    it 'sends a flash notice' do
      hit_update
      expect(flash[:notice]).to eq('User updated')
    end
    it 'responds with a 302' do
      hit_update
      expect(response.status).to eq(302)
    end
  end

  describe '#search' do
    let(:show) { FactoryGirl.create(:show) }
    let(:shift) { FactoryGirl.create(:shift, job_id: job.id, show_id: show.id, user_id: user.id)}
    let(:params) { {"show_id"=>show.id, "search"=>user.name, "controller"=>"users", "action"=>"search", "shift_id"=>shift.id} }
    let(:empty_params) { {"show_id"=>show.id, "search"=>"", "controller"=>"users", "action"=>"search"} }
    let(:wrong_params) { {"show_id"=>show.id, "search"=>"i823y4heogjvough34o2iwhbnlfdkbjlowi", "controller"=>"users", "action"=>"search"} }
    let(:hit_search) { get :search, params: params }
    it 'renders a string when blank' do
      get :search, params: empty_params
      expect(response.body).to eq('No results matching that query')
    end
    it 'renders the search_results template' do
      expect(hit_search).to render_template(:_search_results)
    end
    it 'responds with a status of 200' do
      hit_search
      expect(response.status).to eq(200)
    end
    it 'assigns the @show variable' do
      hit_search
      expect(assigns[:show]).to eq(show)
    end
    describe 'assigns the @results variable' do
      it 'to an empty ActiveRecord::Relation when given a non matching query' do
        get :search, params: wrong_params
        expect(assigns[:results]).to be_empty
      end
      it 'to an ActiveRecord::CollectionProxy containing users' do
        hit_search
        expect(assigns[:results]).to include(user)
      end
    end
  end
end
