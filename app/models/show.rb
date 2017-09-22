class Show < ApplicationRecord
  validate :assign_venue
  belongs_to :venue
  has_many :shifts
  has_many :users, through: :shifts
  validates_associated :venue
  validates_presence_of :start, #:doors, :show_end

  def date
    self.start.strftime('%A, %D')
  end

  def readable(time)
    return time.strftime('%I:%M%p') if time
    'time not set'
  end

  def assign_venue
    venue_abbreviation = nil
    Venue.abbreviations.each do |abbrev|
      venue_abbreviation = abbrev if self.info.include? abbrev
    end
    return self.venue = Venue.find_by(abbreviation: venue_abbreviation) if venue_abbreviation
    self.errors.add(:associated_venue, "ShiftSlot wasn't able to automatically infer the venue for the show on #{self.date}. You should go back to the Google Calendar event and add one of the following to the summary and that should fix the problem: #{Venue.abbreviations.join(', ')}")
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
