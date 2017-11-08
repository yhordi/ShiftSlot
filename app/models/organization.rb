class Organization < ApplicationRecord
  has_many :assignments
  has_many :users, through: :assignments
  has_many :partnerships, dependent: :destroy
  has_many :venues, through: :partnerships, dependent: :destroy
  has_many :shows, through: :venues, dependent: :destroy
  validates_presence_of :name
  validates_uniqueness_of :name
end
