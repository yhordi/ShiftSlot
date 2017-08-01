require 'rails_helper'

RSpec.describe LandingsController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }
  before(:each) do
    allow(request.env['warden']).to receive(:authenticate!).and_return(user)
    allow(controller).to receive(:current_user).and_return(user)
  end

  describe '#index' do
    it 'responds with a status of 200' do
      get :index
      expect(response.status).to eq(200)
    end
    it 'renders the landing index' do
      expect(get :index).to render_template(:index)
    end
  end
end
