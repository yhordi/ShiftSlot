class ShowsController < ApplicationController
  def index
    @org = Organization.find(params[:organization_id])
    @shows = Show.where(organization_id: @org.id)
    render :index
  end

  def show
    @show = Show.find(params[:id])
    render :show
  end

  def new
    @org = Organization.find(params[:organization_id])
    @show = Show.new
    render :new
  end

  def create
    venue = Venue.find(params[:venue_id])
    show = Show.new(show_params)
    show.format_dates(['doors', 'start'], params)
    show.venue = venue
    show.organization_id = params[:organization_id]
    show.save!
    redirect_to show_path(show)
  end

  def import
    errors = []
    org = Organization.find(params[:organization_id])
    shows = params[:shows].map do |show|
      new_show = Show.new()
      new_show.organization = org
      new_show.info = show[1][:info]
      new_show.start = show[1][:start]
      new_show.assign_venue
      new_show.save
      # This isn't saving in some cases where it should. Needs attention.
      if new_show.errors.any?
        error = "#{new_show.info} was not saved: "
        new_show.errors.full_messages.each do |err|
          error << err + " "
        end
        errors << error
      end
    end
    if errors.empty?
      message = {notice: 'All shows imported successfully!'}
    else
      message = {errors: errors.flatten.uniq}
    end
    redirect_to organization_shows_path(org), flash: message
  end

  private

  def show_params
    params.require(:show).permit(:info, :headliner, :date, :info, :recoup, :payout, :event_link, :tickets_link, :door_price)
  end
end
