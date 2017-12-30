class CalendarsController < ApplicationController
  include JSON
  include Bookable
  def sync
    headers = "Bearer #{params[:token]}"
    @org = Organization.find(params[:organization_id])
    url = "https://www.googleapis.com/calendar/v3/calendars/#{@org.gcal_id}/events?key=#{ENV['CAL_KEY']}"
    req = HTTParty.get(url, headers: {"Authorization" => headers})
    @google_shows = build(req.parsed_response)
    @shows = Show.all
    render 'sync'
  end
end
