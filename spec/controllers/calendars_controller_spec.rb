require 'rails_helper'

RSpec.describe CalendarsController, type: :controller do
  describe '#sync' do
    it 'renders the sync template'
    it 'responds with a 200'
    it 'assigns @google_shows'
    it 'assigns @shows'
  end

  describe '#create' do
    it 'saves new shows to the database as parsed from the google response'
    it 'responds with a status of 302'
  end
end
