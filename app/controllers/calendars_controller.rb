class CalendarsController < ApplicationController
  include Bookable
  def sync
    headers = "Bearer #{ENV['TOKEN']}"
    url = "https://www.googleapis.com/calendar/v3/#{ENV['CAL_ID']}/events?key=#{ENV['CAL_KEY']}"
    req = HTTParty.get(url, headers: {"Authorization" => headers})
    @google_shows = build(req.parsed_response)
    @shows = Show.all
    render 'sync'
  end
end
