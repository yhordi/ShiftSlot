require 'rails_helper'

RSpec.describe AssignmentsController, type: :controller do
  describe 'new' do
    it 'assigns the @user variable'
    it 'assigns the @orgs variable'
    it 'responds with a status of 200'
    it 'renders the new view'
  end

  describe 'create' do
    it 'assigns the @org variable'
    it 'responds with a 302'
    context 'on success' do
      it 'sends a success message through flash'
      it 'redirects to root'
    end
    context 'on failure' do
      it 'responds with an error message'
      it 'redirects to the previous page'
    end
  end
end
