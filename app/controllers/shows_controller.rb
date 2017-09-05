class ShowsController < ApplicationController
  def index
    @shows = Show.all
    render :index
  end

  def show
    @show = Show.find(params[:id])
    render :show
  end

  def callback
  end

  def redirect
  end

  private

  def client_options
    {
      client_id: ENV['CLIENT_ID'],
      client_secret: ENV['CLIENT_SECRET'],
      authorization_uri: 'https://accounts.google.com/o/oauth2/auth',
      token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
      scope: Google::Apis::CalendarV3::AUTH_CALENDAR,
      redirect_uri: callback_url
    }
  end
end
