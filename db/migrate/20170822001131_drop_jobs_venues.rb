class DropJobsVenues < ActiveRecord::Migration[5.0]
  def change
    drop_table :jobs_venues
  end
end
