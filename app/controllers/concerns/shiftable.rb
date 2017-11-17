module Shiftable
  extend ActiveSupport::Concern

  def update_shift(params, shift)
    worker = User.find_by(name: params[:worker_name])
    if unschedule_worker?(params)
      remove_worker(shift)
    else
      add_worker_to_shift(worker, shift, params[:organization_id])
    end
  end

  private

  def remove_worker(shift)
    shift.remove_worker(current_user)
    if shift.errors.any?
      return flash[:alert] = shift.errors.full_messages
    end
    shift.save!
    flash[:notice] = 'Worker removed'
  end

  def add_worker_to_shift(worker, shift, org_id)
    if current_user.admin?(org_id)
      shift.user_id = worker.id
      worker = User.find(shift.user_id)
      flash[:notice] = "#{worker.name} is signed up to work!"
    else
      shift.user_id = current_user.id
      flash[:notice] = "You're signed up to work!"
    end
    shift.save!
  end

  def unschedule_worker?(params)
    params[:commit] == 'Unschedule Me' || params[:commit] == 'Remove Worker'
  end

  def schedule_worker?(params)
    params[:commit] == 'Update Worker'
  end
end
