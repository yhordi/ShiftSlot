class VenuesController < ApplicationController
  def index
    # @venue.where(organization.id: params[:organization_id])
    @venues = Venue.all
    render :index
  end

  def new
    @orgs = current_user.all_admin_orgs
    @venue = Venue.new
    render :new
  end

  def create
    venue = Venue.new(venue_params)
    org = Organization.find(params[:organization_id])
    venue.organizations << org
    venue.save
    redirect_to organization_venues_path(org)
  end

  def show
    @venue = Venue.find(params[:id])
    @shows = @venue.shows.order(:start)
    render :show
  end

  private

  def venue_params
    params.require(:venue).permit(:name, :location, :hooks)
  end
end
