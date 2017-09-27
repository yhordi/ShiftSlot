require 'rails_helper'
require_relative '../support/response'
RSpec.describe OmniauthsController, type: :controller do
  describe '/redirect' do
    it 'responds with a status of 302'
    it 'sends a token in params'
  end
  describe '/callback' do
    it 'responds with a status of 302'
    it 'redirects to a url based on environment variables'
  end
end
