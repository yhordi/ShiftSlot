require 'rails_helper'

RSpec.describe OrganizationsController, type: :controller do
  let(:org) { FactoryGirl.create :organization }
  describe '#new' do
    it 'assigns the @org instance variable to a new organization' do
    end
  end
  describe '#create' do
    it 'assigns the @org instance variable to a new organization' do
      post :create,
    end
    it 'responds with a status of 302' do
    end
    context 'on success' do
      it 'saves an org to the database'
      it 'redirects to the user signup page'
    end
    context 'on fail' do
      it 'sends errors back through a flash message'
      it 'redirects to the new organization page'
    end
  end
end
