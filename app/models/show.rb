class Show < ApplicationRecord
  before_save :assign_headliner
  belongs_to :venue
  belongs_to :organization
  has_many :shifts, dependent: :destroy
  has_many :users, through: :shifts
  validates_presence_of :start, :info, :date, :venue_id
  validates_uniqueness_of :info, scope: :date
  def assign_headliner
    if !self.headliner
      self.headliner = self.info
    end
  end

  def assign_venue
    return 'venue already assigned' if self.venue_id
    match_venue
  end

  def start_time
    self.start
  end

  def format_dates(attrs, params)
    attrs.map do |attr|
      date_setup(attr, params)
    end
  end

  def readable_date
    self.start.strftime('%a, %b, %d at %l:%m%p')
  end

  def readable(time)
    return time.strftime('%I:%M%p') if time
    'time not set'
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

  def date_setup(attr, params)
    date = self.date.to_datetime
    date = date.change(
      hour: params["show"][attr + "(4i)"].to_i,
      min: params["show"][attr + "(5i)"].to_i,
    )
    self.write_attribute(attr.to_sym, date)
  end

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
      return nil
    end
  end
end
