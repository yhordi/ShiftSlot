class ShowsController < ApplicationController
  def index
    @venue = Venue.find(params[:venue_id])
    @shows = @venue.shows.order(:start)
    render :index
  end

  def show
    @show = Show.find(params[:id])
    render :show
  end
end
