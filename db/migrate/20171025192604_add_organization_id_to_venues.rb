class AddOrganizationIdToVenues < ActiveRecord::Migration[5.0]
  def change
    add_reference :venues, :organization, index: true
  end
end
