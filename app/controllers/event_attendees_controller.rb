class EventAttendeesController < ApplicationController
		before_action :set_event
	def index
		@attendees = @event.attendees
	end
	def new
		@attendee = @event.attendees.build		
	end	
	def create
		@attendee = @event.attendees.build
		@attendee.save

		redirect_to event_attendees_path(@event,@attendee)
	end
	def show
		@attendee = @event.attendees.find(params[:id]) 
	end
	def edit
		@attendee = @event.attendees.find(params[:id])
	end
	def update
		@attendee = @event.attendees.find(params[:id])
		@attendee.update(attendees_params)

		redirect_to event_attendee_path(@event)
	end

	def destroy
		@attendee = @event.attendees.find(params[:id])
		@attendee.destroy

		redirect_to event_attendees_path(@event)
	end







	protected

	def set_event
		@event = Event.find(params[:event_id])
	end
	def attendees_params
		params.require(:attendee).permit(:name, :event_id)
	end
end
