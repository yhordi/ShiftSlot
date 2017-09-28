class AddAbbreviationToVenue < ActiveRecord::Migration[5.0]
  def change
    add_column :venues, :abbreviation, :string
  end
end
