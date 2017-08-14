class PreferredDay < ApplicationRecord
  belongs_to :user

  def self.days
    ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday']
  end
end
