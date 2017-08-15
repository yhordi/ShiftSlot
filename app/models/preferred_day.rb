class PreferredDay < ApplicationRecord
  belongs_to :user
  validates_uniqueness_of :name, scope: :user_id

  def self.days
    ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday']
  end
end
