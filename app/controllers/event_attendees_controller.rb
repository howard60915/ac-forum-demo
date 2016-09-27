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
		if @attendee.save
			flash[:notice] = "新增參加人員"
		   redirect_to event_attendees_path(@event,@attendee)
		else 
			flash[:alert] = "新增人員失敗"
			render :action => :edit
		end	

	end

	def show
		@attendee = @event.attendees.find(params[:id]) 
	end

	def edit
		@attendee = @event.attendees.find(params[:id])
	end

	def update
		@attendee = @event.attendees.find(params[:id])
		if @attendee.update(attendees_params)
			flash[:notice] = "更新成功"
			redirect_to event_attendee_path(@event)
		else
			flash[:alert] = "更新失敗"
			render :action => :edit
		end	
	end

	def destroy
		@attendee = @event.attendees.find(params[:id])
		@attendee.destroy
		flash[:alert] = "刪除成功"
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
