class Venue < ApplicationRecord
  validates_presence_of :name, :location
  has_many :shows, dependent: :destroy
  has_many :jobs, dependent: :destroy
  has_many :partnerships
  has_many :organizations, through: :partnerships

  protected

  def self.abbreviations
    Venue.all.map do |venue|
      venue.abbreviation
    end
  end

end
