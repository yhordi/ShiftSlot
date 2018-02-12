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

  def edit
    @show = Show.find(params[:id])
    render :edit
  end

  def update
    venue = Venue.find(params[:venue_id])
    show = Show.find(params[:id])
    show.format_dates(['doors', 'start'], params)
    show.venue = venue
    show.update(show_params)
    redirect_to show_path(show)
  end

  def destroy
    show = Show.find(params[:id])
    org = Organization.find(show.organization_id)
    show.delete
    flash[:notice] = 'Your show has been deleted from the app. It will still be imported if you have it in your google calendar.'
    redirect_to organization_shows_path(org)
  end

  def import
    errors = []
    org = Organization.find(params[:organization_id])
    shows = params[:shows].delete_if do |i|
      params[:shows][i][:venue_id].empty?
    end
    shows = params[:shows].map do |show|
      new_show = Show.new()
      new_show.organization = org
      new_show.info = show[1][:info]
      new_show.start = show[1][:start]
      new_show.date = new_show.start.to_date
      new_show.assign_venue
      if !new_show.venue_id
        new_show.venue_id = show[1][:venue_id].to_i
      end
      new_show.save

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
    params.require(:show).permit(:info, :venue_id, :headliner, :date, :info, :recoup, :payout, :event_link, :tickets_link, :door_price)
  end


end
