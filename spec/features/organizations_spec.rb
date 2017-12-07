require 'rails_helper'

RSpec.feature "Organizations", type: :feature do
  let(:org) { FactoryGirl.create :organization}
  let(:user) {FactoryGirl.create :user, organizations: [org]}
  before(:each) do
    user.admin=org
    login_as user
  end
  feature 'edit page' do
    scenario 'a user fills out the General Preferences form and can see their updated organization info' do
      visit edit_organization_path(org.id)
      fill_in 'organization[name]', with: 'HAM'
      click_on 'Update Organization'
      expect(page).to have_content('HAM')
    end
    scenario 'a user fills out the Delete form and is redirected to their personal dashboard'
  end
end
