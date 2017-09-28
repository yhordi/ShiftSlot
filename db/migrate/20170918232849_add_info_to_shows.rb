class AddInfoToShows < ActiveRecord::Migration[5.0]
  def change
    add_column :shows, :info, :string
  end
end
