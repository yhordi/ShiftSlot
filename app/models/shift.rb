class Shift < ApplicationRecord
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

  def remove_worker(current_user)
    return errors.add(:invalid_canellation, 'You cannot cancel your shift from the app within two days of the show. Contact your show organizer for details.')  if invalid_cancellation? && !current_user.admin?(self.show.organization_id)
    self.user_id = nil
    true
  end

  private

  def invalid_cancellation?
    self.show.start <= Date.today.days_since(2)
  end

end
