class ChangeDatetimeFieldsOnShows < ActiveRecord::Migration[5.0]
  def up
    change_column :shows, :doors, :time
    change_column :shows, :start, :time
    add_column :shows, :date, :date
  end

  def down
    change_column :shows, :doors, :datetime
    change_column :shows, :start, :datetime
    remove_column :shows, :date, :date
  end
end
