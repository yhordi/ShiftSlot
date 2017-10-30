class ShowsController < ApplicationController
  def index
    @shows = Show.where(organization_id: params[:organization_id])
    render :index
  end

  def show
    @show = Show.find(params[:id])
    render :show
  end

end
