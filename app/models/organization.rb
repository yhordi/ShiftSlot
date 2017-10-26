class Organization < ApplicationRecord
  has_many :users
  has_many :venues
  has_many :shows, through: :venues
  validates_presence_of :name
  validates_uniqueness_of :name
end
