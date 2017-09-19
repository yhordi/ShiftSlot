class CalendarsController < ApplicationController
  include Bookable
  def sync
    headers = "Bearer #{ENV['TOKEN']}"
    url = "https://www.googleapis.com/calendar/v3/#{ENV['CAL_ID']}/events?key=#{ENV['CAL_KEY']}"
    req = HTTParty.get(url, headers: {"Authorization" => headers})
    @Shows = build(req.parsed_response)
    render 'sync'
  end
end
