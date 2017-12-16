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

  def create
    errors = []
    org = Organization.find(params[:organization_id])
    shows = params[:shows].map do |show|
      new_show = Show.new()
      new_show.organization = org
      new_show.info = show[1][:info]
      new_show.start = show[1][:start]
      new_show.assign_venue
      new_show.save
      # This isn't saving in some cases where it should. Needs attention.
      if new_show.errors.any?
        errors << new_show.errors.full_messages
      end
    end
    redirect_to organization_shows_path(org), flash: {errors: errors.flatten.uniq}
  end
end
