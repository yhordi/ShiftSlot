class CreateAuthorizedJobs < ActiveRecord::Migration[5.0]
  def change
    create_table :authorized_jobs do |t|
      t.belongs_to :user
      t.belongs_to :job
      t.timestamps
    end
  end
end
