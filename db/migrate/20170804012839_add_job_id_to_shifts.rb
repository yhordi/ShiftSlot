class AddJobIdToShifts < ActiveRecord::Migration[5.0]
  def change
    add_column :shifts, :job_id, :integer
  end
end
