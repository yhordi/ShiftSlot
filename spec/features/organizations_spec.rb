require 'rails_helper'

RSpec.feature "Organizations", type: :feature do
  let(:org) { FactoryGirl.create :organization}
  let(:user) {FactoryGirl.create :user, organizations: [org]}
  # let(:venue) {FactoryGirl.create :venue, orgs: [org]}
  # let(:show) {FactoryGirl.create :show}
  # let(:shift) {FactoryGirl.create :shift, venue: venue, job: 'volunteer', user: user}
  before(:each) do
    user.admin=org
    login_as user
    visit edit_organization_path(org.id)
  end
  feature 'edit page' do
    scenario 'a user fills out the General Preferences form and can see their updated organization info' do
      fill_in 'organization[name]', with: 'HAM'
      click_on 'Update Organization'
      expect(page).to have_content('HAM')
    end
    scenario 'a user fills out the Delete form and is redirected to their personal dashboard' do
      p user.shows.any?
      fill_in 'password', with: user.password
      fill_in 'confirm', with: org.name
      click_on 'DESTROY'
      page.driver.browser.switch_to.alert.accept
      expect(page).to have_content('Dashboard')
    end
  end
end
