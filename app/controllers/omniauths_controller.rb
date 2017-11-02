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
      "redirect_uri" => 'http://localhost:3000/redirect',
      'grant_type' => "authorization_code",
      "project_id" => ENV['PROJECT_ID']
    }
    req = HTTParty.post(base, body: data)
    org = Organization.find(params[:state])
    redirect_to organization_sync_path(org, token: req.parsed_response['access_token'])
  end

  def callback
    base = "https://accounts.google.com/o/oauth2/v2/auth"
    data = URI.encode_www_form("client_id" => ENV['CAL_CLIENT_ID'], "redirect_uri" => 'http://localhost:3000/redirect', "response_type" => "code", "state" => params[:organization_id], "scope" => 'https://www.googleapis.com/auth/calendar.readonly')
    redirect_to "#{base}?#{data}"
  end
end
