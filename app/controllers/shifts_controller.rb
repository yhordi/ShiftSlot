class ShiftsController < ApplicationController
  include Shiftable
  def new
    @shift = Shift.new
    @show = Show.find(params[:show_id])
    @jobs = @show.venue.jobs
    render partial: 'new', locals: {show: @show, jobs: @jobs}
  end

  def create
    shift = Shift.create(shift_params)
    shifts = Shift.where(show_id: params[:show_id])
    redirect_to show_path(shift.show_id)
  end

  def edit
    @shift = Shift.find(params[:id])
    @show = Show.find(@shift.show_id)
    @jobs = @show.venue.jobs
    render partial: 'users/search_field', locals: { show: @show, shift: @shift }
  end


  def destroy
    shift = Shift.find(params[:id])
    shift.delete
    redirect_to show_path(shift.show_id)
  end

  def update
    shift = Shift.find(params[:id])
    update_shift(params, shift)
    redirect_to show_path(shift.show_id)
  end

  private

  def shift_params
    params.permit(:show_id, :worker_name, :job_id)
  end
end
