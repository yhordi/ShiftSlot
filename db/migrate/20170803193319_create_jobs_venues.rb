class CreateJobsVenues < ActiveRecord::Migration[5.0]
  def change
    create_table :jobs_venues do |t|
      t.belongs_to :job
      t.belongs_to :venue
      t.timestamps
    end
  end
end
