class Venue < ApplicationRecord
  validates_presence_of :name, :location
  has_many :shows
  has_many :jobs_venues
  has_many :jobs, through: :jobs_venues
end
