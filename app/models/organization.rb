class Organization < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :partnerships
  has_many :venues, through: :partnerships
  has_many :shows, through: :venues
  validates_presence_of :name
  validates_uniqueness_of :name
end
