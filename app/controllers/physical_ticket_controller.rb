class PhysicalTicketController < ApplicationController
  before_filter :authenticate_user!, except: [:new, :create, :show]
  load_resource :conference, find_by: :short_title
  load_and_authorize_resource
  authorize_resource :conference_registrations, class: Registration
  before_action :set_ticket, only: [:show]

  def new
  	@unassigned_ticket_purchases = current_user.ticket_purchases.unassigned.by_conference(@conference)
  	@physical_tickets = current_user.physical_tickets
  end

  def create
  	user = User.find_by(email: user_params[:email])
  	ticket_purchase_id = user_params[:ticket_purchase_id].to_i
  	ticket_purchase = TicketPurchase.find(ticket_purchase_id)
    

    unless user
      redirect_to new_conference_physical_ticket_path,
                  error: 'Could not find user. Please provide a valid email!'
      return
    end

    @physical_ticket = PhysicalTicket.new(ticket_id: ticket_purchase.ticket_id, user_id: user.id, ticket_purchase_id: ticket_purchase.id, conference_id: @conference.id)

    if @physical_ticket.save
      ticket_purchase.update_assigned
      redirect_to new_conference_physical_ticket_path
    else
      redirect_to new_conference_physical_ticket_path,
                  error: @physical_ticket.errors.full_messages.to_sentence
    end
  end

  def show
  end

  protected

  def set_ticket
    @physical_ticket = PhysicalTicket.find(params[:id])
    unless @physical_ticket
      redirect_to conference_tickets_path(@conference.short_title),
                  error: "Can't find a ticket for #{@conference.title} for you. Please buy a ticket first."
    end
  end

  def user_params
  	params.require(:user).permit(:email, :ticket_purchase_id)
  end
end
