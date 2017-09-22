class CalendarsController < ApplicationController
  include JSON
  include Bookable
  def sync
    headers = "Bearer #{ENV['TOKEN']}"
    url = "https://www.googleapis.com/calendar/v3/#{ENV['CAL_ID']}/events?key=#{ENV['CAL_KEY']}"
    req = HTTParty.get(url, headers: {"Authorization" => headers})
    @google_shows = build(req.parsed_response)
    # try sending this as a nested hash
    @shows = Show.all
    render 'sync'
  end

  def create
    p abbreviations
    params[:shows].map do |show|
      new_show = Show.new()
      new_show.info = show[1][:info]
      new_show.start = show[1][:start]
      assign_venue(new_show)
      new_show.save!
    end
  end
end
