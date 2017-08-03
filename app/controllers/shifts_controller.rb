class ShiftsController < ApplicationController
  def new
    @jobs = Show.find(params[:show_id]).venue.jobs
    render partial: 'users/search_field'
  end
end
