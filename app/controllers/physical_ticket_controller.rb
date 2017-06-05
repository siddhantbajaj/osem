class PhysicalTicketController < ApplicationController
  before_filter :authenticate_user!, except: [:new, :create]
  load_resource :conference, find_by: :short_title
  load_and_authorize_resource
  authorize_resource :conference_registrations, class: Registration

  def new
  	@unassigned_ticket_purchases = current_user.ticket_purchases.unassigned.by_conference(@conference)
  end
end
