class ShowsController < ApplicationController
  def index
    # this will be the calendar route
  end

  def show
    @show = Show.find(params[:id])
    render :show
  end
end
