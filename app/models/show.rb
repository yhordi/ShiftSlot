class Show < ApplicationRecord
  belongs_to :venue
  has_many :shifts
  has_many :users, through: :shifts
  validates_associated :venue
  validates_presence_of :start

  def date
    self.start.strftime('%A, %D')
  end

  def readable(time)
    time.strftime('%I:%M%p')
  end

  def day
    self.start.strftime('%A')
  end
end
