class AddCodeAndEmailToOrg < ActiveRecord::Migration[5.0]
  def change
    add_column :organizations, :code, :string
    add_column :organizations, :primary_admin_email, :string
  end
end
