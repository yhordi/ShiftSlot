class ShiftsController < ApplicationController
  def new
    @show = Show.find(params[:show_id])
    @jobs = @show.venue.jobs
    render partial: 'users/search_field', locals: { show: @show }
  end

  def create
    shift = Shift.create(shift_params)
    shifts = Shift.where(show_id: params[:show_id])
    render partial: 'index', locals: { shifts: shifts }
  end

  def destroy
    shift = Shift.find(params[:id])
    shift.delete
    redirect_to show_path(shift.show_id)
  end

  private

  def shift_params
    params.permit(:show_id, :user_id, :job_id)
  end
end
