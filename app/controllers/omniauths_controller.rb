require 'oauth2'
require 'uri'
require 'httparty'
class OmniauthsController < ApplicationController
  include HTTParty
  def redirect
    p '*' * 1000
    base = "https://www.googleapis.com/oauth2/v4/token"
    data = {
      "code" => params[:code],
      "client_id" => ENV['CAL_CLIENT_ID'],
      "client_secret" => ENV['CLIENT_SECRET'],
      "redirect_uri" => 'http://localhost:3000/redirect',
      'grant_type' => "authorization_code",
      "project_id" => ENV['PROJECT_ID']
    }
    p data
    req = HTTParty.post(base, body: data)
    p "*"* 100
    p req
    # p params
    # p"#{base}?#{data}"
  end

  def callback
    base = "https://accounts.google.com/o/oauth2/v2/auth"
    data = URI.encode_www_form("client_id" => ENV['CAL_CLIENT_ID'], "redirect_uri" => 'http://localhost:3000/redirect', "response_type" => "code", "scope" => 'https://www.googleapis.com/auth/calendar.readonly')
    redirect_to "#{base}?#{data}"
    # redirect_to client.auth_code.authorize_url(:redirect_uri => 'http://localhost:3000/callback', scope: 'https://www.googleapis.com/auth/calendar.readonly')
  end
end

# https://accounts.google.com/oauth/authorize?client_id&redirect_uri=http%3A%2F%2Flocalhost%3A3000%2Fcallback&response_type=code
# https://accounts.google.com/o/oauth2/v2/auth?client_id=398191137925-e9scfgdkk3kqg8297cqc58bltoqfgmjq.apps.googleusercontent.com&redirect_uri=http%3A%2F%2Flocalhost%3A3000%2Fcallback&response_type=code&scope=https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fcalendar.readonly

# https://accounts.google.com/oauth/authorize?client_id=398191137925-e9scfgdkk3kqg8297cqc58bltoqfgmjq.apps.googleusercontent.com&redirect_uri=http%3A%2F%2Flocalhost%3A3000%2Fcallback&response_type=code&scope=https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fcalendar.readonly


# "https://www.googleapis.com/oauth2/v4/token?code=4%2FWhGDJcoZ1HNca_16fltZ5myYTz9HKPBYGwx1D7XhirA&client_id=398191137925-e9scfgdkk3kqg8297cqc58bltoqfgmjq.apps.googleusercontent.com&client_secret=WkacavOi1C4kWWwxniPl4_0c-&redirect_uri=http%3A%2F%2Flocalhost%3A3000%2Fredirect&grant_type=authorization_code"
