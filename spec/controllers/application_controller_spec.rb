require 'rails_helper'

describe ApplicationController do
  controller do
    def index
      render plain: 'ham'
    end
  end

  describe '#require_login' do
    it 'redirects to the root path if a user is not logged in' do
      expect(get :index).to redirect_to(root_path)
    end
  end
end
