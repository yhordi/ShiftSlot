class ShowsController < ApplicationController
  def index
    @shows = Show.order(:start)
    @venue = Venue.find(params[:venue_id])
    render :index
  end
end
