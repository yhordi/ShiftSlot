class RemoveOrganizationIdFromVenues < ActiveRecord::Migration[5.0]
  def change
    remove_column :venues, :organization_id
  end
end
