class Shift < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :show
  belongs_to :job
  validates_uniqueness_of :user_id, allow_blank: true, scope: :show_id

  def start
    self.show.start
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
