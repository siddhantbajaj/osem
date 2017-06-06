class RenamePurchaseIdToTicketPurchaseId < ActiveRecord::Migration
  def change
  	rename_column :physical_tickets, :purchase_id, :ticket_purchase_id
  end
end
