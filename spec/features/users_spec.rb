require 'rails_helper'

RSpec.feature "Landing Page", type: :feature do
  let!(:show) { FactoryGirl.create :show}
  let!(:org) {FactoryGirl.create :organization}
  let!(:user) { FactoryGirl.create :user }
  let(:user_attrs) { FactoryGirl.attributes_for :user}
  context 'a user' do
    before(:each) do
      visit root_path
    end
    describe 'login' do
      before(:each) do
        click_on 'Log in'
      end
      scenario 'can log in and see a dashboard' do
        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password
        click_on 'Log in'
        expect(page).to have_content('Signed in successfully.')
      end
    end
    describe 'signup' do
      before(:each) do
        click_on 'Sign up'
        page.find('#organization_id').select org.name
      end
      scenario 'can create an account and see a dashboard' do
        page.find('#organization_id').select org.name
        page.fill_in 'user[name]', with: user_attrs[:name]
        page.fill_in 'user[email]', with: user_attrs[:email]
        page.fill_in 'user[password]', with: user_attrs[:password]
        page.fill_in 'user[password_confirmation]', with: user_attrs[:password]
        click_on 'Sign up'
        expect(page).to have_content('Welcome! You have signed up successfully.')
      end
      scenario 'can see errors when form fields are empty' do
        pending("Considering removal of this test. Handled by html5 form validators. Not a feature.")
        click_on 'Sign up'
        expect(page).to have_content('errors prohibited this user from being saved')
      end
    end
  end
end
