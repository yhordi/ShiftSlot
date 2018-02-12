class CalendarsController < ApplicationController
  include JSON
  include Bookable

  def sync
    headers = "Bearer #{params[:token]}"
    @org = Organization.find(params[:organization_id])
    base = "https://www.googleapis.com/calendar/v3/calendars/#{@org.gcal_id}/events?"
    data = URI.encode_www_form(key: ENV['CAL_KEY'], timeMin: params["state"]["timeMin"], timeMax: params["state"]["timeMax"])
    url = "#{base}?#{data}"
    req = HTTParty.get(url, headers: {"Authorization" => headers})
    @google_shows = build(req.parsed_response)
    @google_shows[:shows] = @google_shows[:shows].sort_by { |s| s.start }
    @google_shows[:need_venue] = []
    @google_shows[:shows].map do |show|
      show.organization = @org
      show.date = show.start.to_date
      show.assign_venue
      if show.venue
        show.save
      else
        @google_shows[:need_venue] << show
        @google_shows[:shows].delete(show)
      end
    end
    render 'sync'
  end

  def new
    @org = Organization.find(params[:organization_id])
    render :new
  end
end
