class Shift < ApplicationRecord
  belongs_to :user
  belongs_to :show
  belongs_to :job
end
