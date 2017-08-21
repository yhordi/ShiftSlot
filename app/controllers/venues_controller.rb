class VenuesController < ApplicationController
  def index
    @venues = Venue.all
    render :index
  end

  def show
    @venue = Venue.find(params[:id])
    @shows = @venue.shows.order(:start)
    render :show
  end
end
