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

end
