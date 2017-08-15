class User < ApplicationRecord
  after_save :add_days
  has_many :preferred_days
  has_many :shifts
  has_many :shows, through: :shifts
  has_many :authorized_jobs
  has_many :jobs, through: :authorized_jobs
  validates_presence_of :name, :email
  validates :name, length: { minimum: 3 }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def authorized?(job)
    self.jobs.include?(job)
  end

  def adjust_jobs(job_ids)
    self.jobs = job_ids.map do |job_id|
      Job.find_by_id(job_id)
    end
  end

  def add_days
    PreferredDay.days.each do |day|
      self.preferred_days << PreferredDay.create(name: day, user_id: self.id)
    end
  end

end
