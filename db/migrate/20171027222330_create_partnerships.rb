class CreatePartnerships < ActiveRecord::Migration[5.0]
  def change
    create_table :partnerships do |t|
      t.belongs_to :organization, null: false
      t.belongs_to :venue, null: false
      t.timestamps null: false
    end
  end
end
