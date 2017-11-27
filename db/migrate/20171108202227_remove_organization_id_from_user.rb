class RemoveOrganizationIdFromUser < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :organization_id, :integer
  end
end
