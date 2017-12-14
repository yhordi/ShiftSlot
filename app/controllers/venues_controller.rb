class VenuesController < ApplicationController
  def index
    # @venue.where(organization.id: params[:organization_id])
    @venues = Venue.all
    render :index
  end
  def new
    @venue = Venue.new
    render :new
  end

  def show
    @venue = Venue.find(params[:id])
    @shows = @venue.shows.order(:start)
    render :show
  end

end
