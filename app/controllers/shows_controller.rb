class ShowsController < ApplicationController
  def index
    @shows = Show.order(:created_at)
    render :index
  end

  def show
    @show = Show.find(params[:id])
    render :show
  end
end
