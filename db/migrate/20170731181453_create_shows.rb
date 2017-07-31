class CreateShows < ActiveRecord::Migration[5.0]
  def change
    create_table :shows do |t|
      t.datetime :doors
      t.datetime :start
      t.datetime :end
      t.belongs_to :venue
      t.timestamps
    end
  end
end
