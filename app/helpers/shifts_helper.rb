module ShiftsHelper
  def available_workers(shift)
    workers = User.all.find_all{ |u| u.available?(shift.show) && u.authorized?(shift.job) }
    return workers if !workers.empty?
    "No workers are available to work that day that are authorized for that job."
  end
end
