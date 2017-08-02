class Shift < ApplicationRecord
  belongs_to :user
  belongs_to :show
  validates_associated :show
end
