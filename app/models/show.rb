class Show < ApplicationRecord
  belongs_to :venue
  has_many :shifts
  has_many :users, through: :shifts
  validates_associated :venue
  validates_presence_of :start, #:doors, :show_end

  def date
    self.start.strftime('%A, %D')
  end

  def readable(time)
    time.strftime('%I:%M%p')
  end

  def day
    self.start.strftime('%A')
  end

  def staffed?
    return false if self.shifts.empty?
    self.shifts.each do |shift|
      return false if !shift.user_id
    end
    true
  end

  def start_time
    self.start
  end

  def already_working?(user)
    self.shifts.map{ |shift| shift.user_id }.include?(user.id)
  end

  def self.available_shifts_for(current_user)
    shows = Show.all.select { |show| !show.already_working?(current_user) }
    shifts = []
    shows.map do |show|
      shifts << show.shifts.select { |shift| current_user.authorized?(shift.job) && shift.user_id == nil }
    end
    shifts.flatten!
  end

end
