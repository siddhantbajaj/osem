class PhysicalTicket < ActiveRecord::Base
	belongs_to :conference
	belongs_to :user
	belongs_to :ticket_purchases
	belongs_to :ticket
end
