class AddOrganizationIdToUser < ActiveRecord::Migration[5.0]
  def change
    add_reference :users, :organization, index: true
  end
end
