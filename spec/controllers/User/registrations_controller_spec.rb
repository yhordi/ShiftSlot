require 'rails_helper'

RSpec.describe User::RegistrationsController, type: :controller do
  let(:org) { FactoryGirl.create :organization}
  let(:user_attrs) { FactoryGirl.attributes_for :user }
  before :each do
    request.env['devise.mapping'] = Devise.mappings[:user]
  end
  describe '#new' do
    it 'assigns the @org variable when passed an org_id in params' do
      get :new, params: {org_id: org.id}
      expect(assigns(:org)).to eq(org)
    end
  end
  describe '#create' do
    it 'associates a user with an organization' do
      user_attrs[:organization_id] = org.id
      post :create, params: { user: user_attrs }
      expect(User.last.organizations).to include(org)
    end
  end
end
