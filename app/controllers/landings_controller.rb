require 'rest-client'
class LandingsController < ApplicationController
  skip_before_action :require_login, only: :index
  def index
    response =  RestClient.get("https://www.googleapis.com/calendar/v3/calendars/3lemps5ktgd5nuactaul1nr9pk%40group.calendar.google.com/events?key=#{ENV['CAL_KEY']}"
)
  lakdsjflkaj
    if current_user
      @shifts = Show.available_shifts_for(current_user)
    end
    render 'index'
  end
end
