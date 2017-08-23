class Venue < ApplicationRecord
  validates_presence_of :name, :location
  has_many :shows, dependent: :destroy
  has_many :jobs, dependent: :destroy
end
