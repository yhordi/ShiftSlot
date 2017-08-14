class CreatePreferredDays < ActiveRecord::Migration[5.0]
  def change
    create_table :preferred_days do |t|
      t.string :name, null: false
      t.timestamps
    end
  end
end
