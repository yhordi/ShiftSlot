require 'oauth2'
require 'uri'
require 'httparty'
class OmniauthsController < ApplicationController
  include HTTParty
  def redirect
    base = "https://www.googleapis.com/oauth2/v4/token"
    data = {
      "code" => params[:code],
      "client_id" => ENV['CAL_CLIENT_ID'],
      "client_secret" => ENV['CLIENT_SECRET'],
      "redirect_uri" => ENV['REDIRECT_URI'],
      'grant_type' => "authorization_code",
      "project_id" => ENV['PROJECT_ID']
    }
    req = HTTParty.post(base, body: data)
    state = JSON.parse(params[:state])
    org = Organization.find(state["org_id"])
    redirect_to organization_sync_path(org, token: req.parsed_response['access_token'], state: state)
  end

  def callback
    DateTime.parse("2018-02-04T18:08:09-08:00")
    time_min = DateTime.parse(params[:timeMin])
    time_min= time_min.new_offset("-0800")
    time_min = time_min.rfc3339
    time_max = DateTime.parse(params[:timeMax])
    time_max = time_max.new_offset("-0800")
    time_max = time_max.rfc3339
    base = "https://accounts.google.com/o/oauth2/v2/auth"
    state = {"org_id" => params[:organization_id], "timeMin" => time_min, "timeMax" => time_max}.to_json
    data = URI.encode_www_form("client_id" => ENV['CAL_CLIENT_ID'], "redirect_uri" => ENV['REDIRECT_URI'], "response_type" => "code", "state" => state, "scope" => 'https://www.googleapis.com/auth/calendar.readonly')
    redirect_to "#{base}?#{data}"
  end
end
