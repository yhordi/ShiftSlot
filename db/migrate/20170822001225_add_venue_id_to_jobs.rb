class AddVenueIdToJobs < ActiveRecord::Migration[5.0]
  def change
    add_column :jobs, :venue_id, :integer
  end
end
