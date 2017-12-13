class AddAuthPendingToAssignment < ActiveRecord::Migration[5.0]
  def change
    add_column :assignments, :auth_pending, :boolean, default: false
  end
end
