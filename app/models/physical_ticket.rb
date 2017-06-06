class PhysicalTicket < ActiveRecord::Base
	belongs_to :conference
	belongs_to :user
	belongs_to :ticket_purchase
	belongs_to :ticket

	validates :user, uniqueness: true

end
