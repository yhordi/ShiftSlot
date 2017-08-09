class Shift < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :show
  belongs_to :job
  validates_uniqueness_of :user_id, allow_blank: true, scope: :show_id
end
