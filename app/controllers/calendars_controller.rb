class CalendarsController < ApplicationController
  def sync
    headers = "Bearer #{ENV['TOKEN']}"
    url = "https://www.googleapis.com/calendar/v3/#{ENV['CAL_ID']}/events?key=#{ENV['CAL_KEY']}"
    req = HTTParty.get(url, headers: {"Authorization" => headers})
    # p url
    # p "!"*50
    # p req
    # p "*"*50
    p req.response
  end
end
