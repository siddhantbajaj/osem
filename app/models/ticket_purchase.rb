class TicketPurchase < ActiveRecord::Base
  belongs_to :ticket
  belongs_to :user
  belongs_to :conference

  validates :ticket_id, :user_id, :conference_id, :quantity, presence: true

  validates :quantity, numericality: { greater_than: 0 }

  delegate :title, to: :ticket
  delegate :description, to: :ticket
  delegate :price, to: :ticket
  delegate :price_cents, to: :ticket
  delegate :price_currency, to: :ticket

  has_many :physical_tickets

  scope :paid, -> { where(paid: true) }
  scope :unpaid, -> { where(paid: false) }
  scope :assigned, -> { where(assigned: true) }
  scope :unassigned, -> { where(assigned: false) }
  scope :by_conference, ->(conference) { where(conference_id: conference.id) }
  scope :by_user, ->(user) { where(user_id: user.id) }

  def self.purchase(conference, user, purchases)
    errors = []
    ActiveRecord::Base.transaction do
      conference.tickets.each do |ticket|
        quantity = purchases[ticket.id.to_s].to_i
        # if the user bought the ticket and is still unpaid, just update the quantity
        if ticket.bought?(user) && ticket.unpaid?(user)
          purchase = update_quantity(conference, quantity, ticket, user)
        else
          purchase = purchase_ticket(conference, quantity, ticket, user)
        end

        if purchase && !purchase.save
          errors.push(purchase.errors.full_messages)
        end
      end
    end
    errors.join('. ')
  end

  def self.purchase_ticket(conference, quantity, ticket, user)
    if quantity > 0
      purchase = new(ticket_id: ticket.id,
                     conference_id: conference.id,
                     user_id: user.id,
                     quantity: quantity,
                     paid: ticket.price_cents.zero?)
    end
    purchase
  end

  def self.update_quantity(conference, quantity, ticket, user)
    purchase = TicketPurchase.where(ticket_id: ticket.id,
                                    conference_id: conference.id,
                                    user_id: user.id,
                                    paid: false).first

    purchase.quantity = quantity if quantity > 0
    purchase
  end

  def update_assigned
    if self.quantity == self.physical_tickets.count
      self.assigned = true
      self.save
    end
  end

  def assigned_tickets_count
    self.physical_tickets.count
  end

end
