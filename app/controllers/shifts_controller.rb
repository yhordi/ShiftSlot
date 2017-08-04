class ShiftsController < ApplicationController
  def new
    @show = Show.find(params[:show_id])
    @jobs = @show.venue.jobs
    render partial: 'users/search_field', locals: { show: @show }
  end

  def create
    shift = Shift.create(shift_params)
    render partial: 'index'
  end

  private

  def shift_params
    params.permit(:show_id, :user_id, :job_id)
  end
end
