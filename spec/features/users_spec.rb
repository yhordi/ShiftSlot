require 'rails_helper'

RSpec.feature "Users", type: :feature do
  let!(:show) { FactoryGirl.create :show}
  let!(:org) {FactoryGirl.create :organization}
  let!(:user) { FactoryGirl.create :user }
  describe 'login' do
    scenario 'can log in and see a dashboard' do
      visit root_path
      click_on 'Log in'
      page.find('#user_organization_id').select org.name
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_on 'Log in'
      expect(page).to have_content('Signed in successfully.')
    end
  end
end
