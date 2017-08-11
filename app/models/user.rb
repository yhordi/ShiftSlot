class User < ApplicationRecord
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

  def add_new_jobs(jobs)
    p "*"*90
    jobs.each do |job|
      self.jobs << Job.find_by_id(job) if !authorized?(job)
    end
    p jobs
  end

  def adjust_jobs
  end

end
