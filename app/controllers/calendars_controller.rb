class CalendarsController < ApplicationController
  include JSON
  include Bookable
  def sync
    headers = "Bearer #{params[:token]}"
    url = "https://www.googleapis.com/calendar/v3/#{ENV['CAL_ID']}/events?key=#{ENV['CAL_KEY']}"
    req = HTTParty.get(url, headers: {"Authorization" => headers})
    @google_shows = build(req.parsed_response)
    @shows = Show.all
    render 'sync'
  end

  def create
    errors = []
    shows = params[:shows].map do |show|
      new_show = Show.new()
      new_show.info = show[1][:info]
      new_show.start = show[1][:start]
      new_show.save
      if new_show.errors.any?
        errors << new_show.errors.full_messages
      end
    end
    redirect_to calendar_path, flash: {errors: errors}
  end
end
