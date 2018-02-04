class Organization < ApplicationRecord
  has_many :assignments
  has_many :users, through: :assignments, after_add: :authorize_volunteer
  has_many :partnerships, dependent: :destroy
  has_many :venues, through: :partnerships, dependent: :destroy
  has_many :shows, through: :venues, dependent: :destroy
  validates_presence_of :name
  validates_uniqueness_of :name

  def authorized_user?(user)
    assign = Assignment.find_match(user_id: user.id, organization_id: self.id)
    return false if !assign
    assign.authorized?
  end

  def total_unauthorized
    assignments = self.assignments.to_a.delete_if { |assignment| assignment.authorized }
    assignments.count
  end

  def any_unauthorized?
    self.assignments.find { |a| !a.authorized? }
  end

  def any_admins?
    self.users.find { |user| user.admin?(self.id) }
  end

  def upcoming_shows(index = 4)
    upcoming = self.shows.order(:start).select do |show|
      show.start > Time.now
    end
    upcoming[0..index]
  end

  def this_week_in_shows
    self.shows.where(date: Time.now.midnight..Time.now + 7.days)
  end

  private

  def authorize_volunteer(worker)
    volunteer_positions.each do |job|
      worker.jobs << job
    end
  end

  def volunteer_positions
    Job.all.select do |job|
      job.venue.organizations.include?(self) && job.title == 'volunteer'
    end
  end
end
