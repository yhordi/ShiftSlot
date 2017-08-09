class ShiftsController < ApplicationController
  def new
    @shift = Shift.new
    @show = Show.find(params[:show_id])
    @jobs = @show.venue.jobs
    render partial: 'new', locals: {show: @show, jobs: @jobs}
  end

  def create
    shift = Shift.create(shift_params)
    shifts = Shift.where(show_id: params[:show_id])
    render partial: 'index', locals: { shifts: shifts }
  end

  def edit
    @shift = Shift.find(params[:id])
    @show = Show.find(@shift.show_id)
    @jobs = @show.venue.jobs
    render partial: 'users/search_field', locals: { show: @show, shift: @shift }
  end

  def update
    shift = Shift.find(params[:id])
    shift.user_id = params[:user_id]
    shift.save
    render plain: "#{User.find(params[:user_id]).name} scheduled for the shift"
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
