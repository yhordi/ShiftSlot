class ChangeAuthPendingToAuthorized < ActiveRecord::Migration[5.0]
  def change
    rename_column :assignments, :auth_pending, :authorized
  end
end
