class AddAdminToAssignments < ActiveRecord::Migration[5.0]
  def change
    add_column :assignments, :admin, :boolean, default: false
  end
end
