class User < ApplicationRecord
  after_save :add_days
  has_many :assignments
  has_many :organizations, through: :assignments
  has_many :preferred_days
  has_many :shifts
  has_many :shows, through: :shifts
  has_many :authorized_jobs
  has_many :jobs, through: :authorized_jobs
  validates_presence_of :name, :email
  validates :name, length: { minimum: 3 }
  validates_uniqueness_of :email
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def authorized?(job)
    self.jobs.include?(job)
  end

  def adjust_jobs(job_ids)
    return remove_jobs if job_ids == nil
    self.jobs = job_ids.map do |job_id|
      Job.find_by_id(job_id)
    end
  end

  def add_days
    PreferredDay.days.each do |day|
      self.preferred_days << PreferredDay.create(name: day, user_id: self.id)
    end
  end

  def available?(show)
    !scheduled?(show) && can_work?(show)
  end

  def venues
    clubs = self.jobs.map do |job|
      job.venue
    end
    clubs.uniq
  end

  def admin?(org_id)
    assignment = self.assignments.find do |assign|
      assign.organization_id == org_id
    end
    assignment.admin
  end

  private

  def remove_jobs
    self.jobs.delete_all
  end

  def can_work?(show)
    work_day = self.preferred_days.find do |day|
      show.day == day.name
    end
    return true if work_day.preferred != false
    false
  end

  def scheduled?(show)
    self.shifts.each do |shift|
      return true if shift.show.date == show.date
    end
    false
  end

end
