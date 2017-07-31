class ShowsController < ApplicationController
  def index
    @shows = Show.all
    @venue = Venue.find(params[:venue_id])
    render :index
  end
end
