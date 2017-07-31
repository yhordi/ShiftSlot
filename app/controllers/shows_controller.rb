class ShowsController < ApplicationController
  def index
    @venue = Venue.find(params[:venue_id])
    @shows = @venue.shows.order(:start)
    render :index
  end
end
