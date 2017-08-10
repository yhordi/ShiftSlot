class CreateShifts < ActiveRecord::Migration[5.0]
  def change
    create_table :shifts do |t|
      t.belongs_to :user
      t.belongs_to :show
      t.string :position
      t.timestamps
    end
  end
end
