class JobsVenue < ApplicationRecord
  belongs_to :job
  belongs_to :venue
end
