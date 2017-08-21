class AddHeadlinerToShow < ActiveRecord::Migration[5.0]
  def change
    # This column will be removed in a later release
    add_column :shows, :headliner, :string
  end
end
