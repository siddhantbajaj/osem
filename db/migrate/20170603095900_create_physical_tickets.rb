class CreatePhysicalTickets < ActiveRecord::Migration
  def change
    create_table :physical_tickets do |t|
      t.integer :ticket_id, null: false
      t.integer :user_id, null: false
      t.integer :purchase_id, null: false
      t.integer :conference_id, null: false

      t.timestamps null: false
    end
  end
end
