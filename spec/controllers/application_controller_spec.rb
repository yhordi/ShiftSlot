require 'rails_helper'

describe ApplicationController do
  controller do
    def index
      render text: 'ham'
    end
  end
  let(:user) { FactoryGirl.create(:user) }
  before(:each) do
    allow(request.env['warden']).to receive(:authenticate!).and_return(user)
    allow(controller).to receive(:current_user).and_return(user)
  end

  describe '#require_login' do
    it 'redirects to the root path if a user is not logged in' do
      get :index
    end
  end
end
