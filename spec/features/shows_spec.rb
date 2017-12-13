require 'rails_helper'

RSpec.feature "Shows", type: :feature do
  let!(:org) { FactoryGirl.create :organization }
  let!(:venue) { FactoryGirl.create :venue, organizations: [org] }
  let!(:show) { FactoryGirl.create :show, organization: org, venue: venue }
  let!(:job) { FactoryGirl.create :job, venue: venue}
  let!(:user) { FactoryGirl.create :user, jobs: [job, Job.find_by(title: 'volunteer')], organizations: [org] }
  describe 'shows#show page' do
    context 'a user' do
      let(:shift) { FactoryGirl.create :shift, job: job, user_id: nil }
      before(:each) do
        show.shifts << shift
        user.jobs << job
        login_as(user)
      end
      context 'without organization authorization' do
        scenario 'sees a message about being unauthorized' do
          visit show_path(show.id)
        end
      end
      context 'with organization authorization' do
        before(:each) do
          assign = Assignment.find_match(user_id: user.id, organization_id: org.id)
          assign.authorized = true
          assign.save
          visit show_path(show.id)
        end
        scenario 'can see info for a show that has been booked' do
          expect(page).to have_content(show.info)
        end
        scenario 'can sign up to work a shift at a show', js: true do
          click_on 'Sign Up'
          expect(page).to have_content("You're signed up to work!")
        end
        scenario 'can unschedule themselves if they are signed up to work' do
          click_on 'Sign Up'
          page.find_by_id('unschedule').click
          page.driver.browser.switch_to.alert.accept
          expect(page).to have_content('Worker removed')
        end
      end
    end
    context 'an admin' do
      let(:admin) { FactoryGirl.create(:admin, organizations: [org])}
      before(:each) do
        admin.admin = org
        assign = Assignment.find_match(user_id: admin.id, organization_id: org.id)
        assign.authorized = true
        assign.save
        login_as(admin)
        visit show_path(show.id)
      end
      scenario 'can create a new shift' do
        page.find_by_id('get-shift-form').click
        click_on 'Create Shift'
        expect(page).to have_content('Select a Worker')
      end
      scenario 'can assign a worker to a shift'
      scenario 'can remove a worker from a shift'
    end
  end
end
