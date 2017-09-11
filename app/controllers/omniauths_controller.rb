require 'oauth2'
class OmniauthsController < ApplicationController
  def redirect

  end

  def callback
    client = OAuth2::Client.new(ENV['CAL_CLIENT_ID'], ENV['CLIENT_SECRET'], :site => 'localhost:3000')

  end
end
