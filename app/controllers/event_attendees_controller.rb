class EventAttendeesController < ApplicationController
		before_action :set_event
	def index
		@attendees = @event.attendees
	end
	def new
		@attendee = @event.attendees.build		
	end	









	protected

	def set_event
		@event = Event.find(params[:event_id])
	end
end
