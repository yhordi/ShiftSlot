class Shift < ApplicationRecord
  # before_save :authorized?
  belongs_to :user, optional: true
  belongs_to :show
  belongs_to :job
  validates_uniqueness_of :user_id, allow_blank: true, scope: :show_id
  validate :authorized?

  def authorized?
    user = User.find_by(id: self.user_id)
    if user && !user.jobs.include?(self.job)
      errors.add(:authorization, "#{user.name} is not authorized to work #{self.job.title}")
    end
  end
end
