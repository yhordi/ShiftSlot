class VenuesController < ApplicationController

  def index
    @venues = Venue.all
    render :index
  end
end
