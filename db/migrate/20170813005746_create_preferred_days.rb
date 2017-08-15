class CreatePreferredDays < ActiveRecord::Migration[5.0]
  def change
    create_table :preferred_days do |t|
      t.string :name
      t.belongs_to :user
      t.boolean :preferred
      t.timestamps
    end
  end
end
