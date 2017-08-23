class Job < ApplicationRecord
  has_many :authorized_jobs
  has_many :users, through: :authorized_jobs
  belongs_to :venue
  has_one :shift

  validates_uniqueness_of :title, scope: :venue
end
