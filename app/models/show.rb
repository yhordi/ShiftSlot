class Show < ApplicationRecord
  belongs_to :venue
  validates_associated :venue
  validates_presence_of :start

  def date
    self.start.to_date
  end
end
