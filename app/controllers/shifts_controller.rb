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
    worker = User.find_by(name: params[:worker_name])
    if params[:commit] == 'Unschedule Me'
      shift.user_id = nil
    elsif current_user.admin
      shift.user_id = worker.id
    else
      shift.user_id = current_user.id
    end
    shift.save
    if shift.user_id
      if !current_user.admin
        flash[:notice] = "You're signed up to work!"
      elsif current_user.admin
        worker = User.find(shift.user_id)
        flash[:notice] = "#{worker.name} is signed up to work!"
      end
    else
      flash[:notice] = 'Worker removed'
    end
    redirect_to show_path(shift.show_id)
  end
  private

  def shift_params
    params.permit(:show_id, :worker_name, :job_id)
  end
end
