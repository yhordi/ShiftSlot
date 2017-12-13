class Assignment < ApplicationRecord
  belongs_to :user
  belongs_to :organization
  def self.find_match(user_id:, organization_id:)
    self.where(user_id: user_id, organization_id: organization_id)[0]
  end

  def authorized?
    self.authorized
  end

  def self.create_and_authorize(user_id:, organization_id:)
    assign = self.create(user_id: user_id, organization_id: organization_id)
    assign.authorized = true
    assign.save
    assign
  end
end
