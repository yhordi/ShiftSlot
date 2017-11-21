require 'rails_helper'

RSpec.feature "Shows", type: :feature do
  let!(:org) { FactoryGirl.create :organization }
  let!(:venue) { FactoryGirl.create :venue, organizations: [org] }
  describe 'shows#show page' do
    context 'a user' do
      let(:user) { FactoryGirl.create :user }
      let(:job) { FactoryGirl.create :job, venue: venue}
      let!(:show) { FactoryGirl.create :show, organization: org, venue: venue }
      let(:shift) { FactoryGirl.create :shift, job: job, user_id: nil }
      before(:each) do
        show.shifts << shift
        user.jobs << job
        login_as(user)
        visit show_path(show.id)
      end
      scenario 'can see info for a show that has been booked' do
        expect(page).to have_content(show.info)
      end
      scenario 'can sign up to work a shift at a show', js: true do
        click_on 'Sign Up'
        expect(page).to have_content("You're signed up to work!")
      end
    end
    context 'an admin' do

    end
  end
end
