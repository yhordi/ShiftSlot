require 'rails_helper'

RSpec.feature "Admins", type: :feature do
  describe 'organization dashoard' do
    let(:org) { FactoryGirl.create(:organization)}
    let(:venue) { FactoryGirl.create(:venue, organizations: [org])}
    let(:admin) { FactoryGirl.create(:admin, organizations: [org])}
    before(:each) do
      admin.admin = org
      login_as(admin)
      visit organization_path(org.id)
    end
    context 'can navigate to their organization dashboard and' do
      scenario 'can see administrative info panels on that page' do
        expect(page).to have_content("#{org.name}'s workers/volunteers")
      end
      scenario 'can see the next five upcoming shows' do
        5.times { FactoryGirl.create(:show, organization_id: org.id, venue: venue) }
        expect(page).to have_content(Show.last.headliner)
      end
      scenario 'can see a calendar for the next week' do
        expect(page).to have_content(Time.now.day)
      end
    end
  end
end
