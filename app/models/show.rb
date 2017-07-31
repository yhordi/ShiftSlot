class Show < ApplicationRecord
  belongs_to :venue
  validates_associated :venue
  validates_presence_of :start

  def date
    self.start.strftime('%A, %D')
  end

  def readable(time)
    time.strftime('%I:%M%p')
  end
end
