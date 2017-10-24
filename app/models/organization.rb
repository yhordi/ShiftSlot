class Organization < ApplicationRecord
  has_many :users
  has_many :venues
  validates_presence_of :name
  validates_uniqueness_of :name
end
