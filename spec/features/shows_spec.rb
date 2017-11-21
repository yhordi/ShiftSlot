require 'rails_helper'

RSpec.feature "Shows", type: :feature do
  describe 'shows#show page' do
    context 'a user' do
      scenario 'can see info for a show that has been booked'
      scenario 'can sign up to work a shift at a show'
    end
    context 'an admin' do

    end
  end
end
