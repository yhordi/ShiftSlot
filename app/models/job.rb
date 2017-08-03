class Job < ApplicationRecord
  has_many :authorized_jobs
  has_many :users, through: :authorized_jobs
  has_many :jobs_venues
  has_many :jobs, through: :jobs_venues
end
