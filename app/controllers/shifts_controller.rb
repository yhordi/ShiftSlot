class ShiftsController < ApplicationController
  def new
    @show = Show.find(params[:show_id])
    @jobs = @show.venue.jobs
    render partial: 'users/search_field', locals:{ show: @show }
  end
end
