require 'rails_helper'

RSpec.feature "Admins", type: :feature do
  describe 'organization dashoard' do
    let(:org) { FactoryGirl.create(:organization)}
    let(:admin) { FactoryGirl.create(:admin, organizations: [org])}
    before(:each) do
      admin.admin = org
      login_as(admin)
      visit organization_path(org.id)
    end
    scenario 'can navigate to there organization dashboard and see info on that page' do
      expect(page).to have_content("#{org.name}'s workers/volunteers")
    end
  end
end
