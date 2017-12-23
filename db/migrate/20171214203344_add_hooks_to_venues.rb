class AddHooksToVenues < ActiveRecord::Migration[5.0]
  def change
    add_column :venues, :hooks, :string
  end
end
