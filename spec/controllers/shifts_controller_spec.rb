require 'rails_helper'

RSpec.describe ShiftsController, type: :controller do
  describe '#new' do
    let(:job) { FactoryGirl.create(:job) }
    let(:venue) { FactoryGirl.create(:venue) }
    let(:show) { FactoryGirl.create(:show, venue_id: venue.id) }
    let(:user) { FactoryGirl.create(:user) }
    let(:hit_show) { get :new, params: {show_id: show.id} }
    before(:each) do
      sign_in user
    end
    it 'responds with a status of 200' do
      hit_show
      expect(response.status).to eq(200)
    end
    it 'assigns the @jobs variable' do
      show.venue.jobs << job
      job.save
      hit_show
      expect(assigns(:jobs)).to include(job)
    end
    it 'assigns the @show variable' do
      hit_show
      expect(assigns(:show)).to eq(show)
    end
    it 'renders the _search_field template' do
      expect(hit_show).to render_template('_search_field')
    end
  end

  describe '#create' do
    it 'saves a shift to the database'
    it 'responds with the newly created shift as a partial'
    it 'responds with a status of 200'
  end
end
