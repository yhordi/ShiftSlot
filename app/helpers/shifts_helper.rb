module ShiftsHelper
  def available_workers(shift)
    workers = User.all.find_all{ |u| u.available?(shift.show) && u.authorized?(shift.job) }
    workers = workers.map {|w| w.name}
    workers.insert(0, 'Select a Worker')
    return workers if workers.length > 1
    "No workers are available to work that day that are authorized for that job."
  end
end
