class Shift < ApplicationRecord
  belongs_to :user
  belongs_to :show
  belongs_to :job
  validates_uniqueness_of :user_id, scope: :show
end
