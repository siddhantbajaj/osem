class AddAssignedToTicketPurchases < ActiveRecord::Migration
  def change
    add_column :ticket_purchases, :assigned, :boolean, default: false
  end
end
