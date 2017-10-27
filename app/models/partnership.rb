class Partnership < ApplicationRecord
  belongs_to :organization
  belongs_to :venue
end
