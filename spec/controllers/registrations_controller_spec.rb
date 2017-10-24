require 'rails_helper'

RSpec.describe User::RegistrationsController, type: :controller do
  before :each do
    request.env['devise.mapping'] = Devise.mappings[:user]
  end
  describe '#new' do
    let(:org) { FactoryGirl.create :organization}
    it 'assigns the @org variable when passed an org_id in params' do
      get :new, params: {org_id: org.id}
      expect(assigns(:org)).to eq(org)
    end
  end
  describe '#create' do
    xit 'saves a new user to the database' do
      pending 'awaiting implementation'
    end
  end
end
