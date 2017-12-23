class AddFieldsToShow < ActiveRecord::Migration[5.0]
  def change
    add_column :shows, :recoup, :decimal
    add_column :shows, :payout, :decimal
    add_column :shows, :event_link, :string
    add_column :shows, :tickets_link, :string
    add_column :shows, :door_price, :decimal
    add_column :shows, :all_ages, :boolean
    add_column :shows, :booked_by_id, :integer
  end
end


# - Expenses to Recoup
# - Payout
# - Event link
# - Tickets link
# - advance price
# - doors price
# - all ages?
