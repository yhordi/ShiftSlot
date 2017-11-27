class AddOrganizationIdToShows < ActiveRecord::Migration[5.0]
  def change
    add_reference :shows, :organization, index: true
  end
end
