require 'rails_helper'

RSpec.describe VenuesController, type: :controller do
  describe '#index' do
    before(:each) do
    end
    it 'assigns the @venues variable' do
      get :index
      expect(assigns(:venues)).to be_an(ActiveRecord::Relation)
    end
    it 'responds with a status of 200' do
      get :index
      expect(response.status).to eq(200)
    end
    it 'renders the index page' do
      expect(get :index).to render_template(:index)
    end
  end
end
