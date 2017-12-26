class Show < ApplicationRecord
  belongs_to :venue
  belongs_to :organization
  has_many :shifts
  has_many :users, through: :shifts
  validates_presence_of :start, :info
  validates_presence_of :venue_id, message: "ShiftSlot couldn't infer what venue this show is being booked at. Either add a hook to your venue in the app, or put the venue name in the google calendar event"

  def readable(time)
    return time.strftime('%I:%M%p') if time
    'time not set'
  end

  def assign_venue
    return 'venue already assigned' if self.venue_id
    match_venue
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
    return [] if shifts.empty?
    shifts.flatten!
  end

  private

  def match_venue
    self.organization.venues.each do |venue|
      regex = Regexp.new("\\b#{venue.name}\\b")
      return self.venue = venue if self.info.match(regex)
      match_venue_by_hook(venue)
    end
  end

  def match_venue_by_hook(venue)
    if venue.hooks
      venue.parsed_hooks.each do |hook|
        regex = Regexp.new("\\b#{hook}\\b")
        return self.venue = venue if self.info.match(regex)
      end
    else
      nil
    end
  end


end
