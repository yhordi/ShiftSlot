class VenuesController < ApplicationController
  def index
    @venues = Venue.all
    render :index
  end

  def show
    p params
    p "*"*100
    @venue = Venue.find(params[:id])
    p @venue
    @shows = @venue.shows.order(:start)
    render :show
  end
end
