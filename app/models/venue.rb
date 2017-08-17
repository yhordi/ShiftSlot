class Venue < ApplicationRecord
  validates_presence_of :name, :location
  has_many :shows, dependent: :destroy
  has_many :jobs_venues, dependent: :destroy
  has_many :jobs, through: :jobs_venues, dependent: :destroy
end
