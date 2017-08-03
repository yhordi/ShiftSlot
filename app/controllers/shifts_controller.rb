class ShiftsController < ApplicationController
  def new
    p params
    @jobs = Show.find(params[:show_id]).venue.jobs
    p @jobs
    render partial: 'new'
  end
end
