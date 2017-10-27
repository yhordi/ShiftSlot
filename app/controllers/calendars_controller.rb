class CalendarsController < ApplicationController
  include JSON
  include Bookable
  def sync
    headers = "Bearer #{params[:token]}"
    org = current_user.organization
    url = "https://www.googleapis.com/calendar/v3/calendars/#{org.gcal_id}/events?key=#{ENV['CAL_KEY']}"
    req = HTTParty.get(url, headers: {"Authorization" => headers})
    @google_shows = build(req.parsed_response)
    @shows = Show.all
    render 'sync'
  end

  def create
    errors = []
    shows = params[:shows].map do |show|
      new_show = Show.new()
      new_show.organization = current_user.organization
      new_show.info = show[1][:info]
      new_show.start = show[1][:start]
      new_show.save
      if new_show.errors.any?
        errors << new_show.errors.full_messages
      end
    end
    redirect_to shows_path(current_user.organization), flash: {errors: errors}
  end
end
