class EventsController < ApplicationController
	#GET/events/index
	#GET/events
	def index
		@events = Event.all
	end	
	#GET/events/new，因為是新生成，所以name & description內都是空的
	def new
		@event = Event.new
	end	
	#GET events/show/:id，因為是用find method，所以name & description會有原先event的資料
	def show
        @event = Event.find(params[:id])
        @page_title = @event.name
	end	
	#GET events/edit/:id
	def edit
		@event = Event.find(params[:id])
	end	

	def update
	  @event = Event.find(params[:id])
	  @event.update(event_params)

	  redirect_to :action => :show, :id => @event
	end

	def destroy
	  @event = Event.find(params[:id])
	  @event.destroy

	  redirect_to :action => :index
	end

	#POST/events/create
	def create
		@event = Event.new( event_params )
		@event.save

		redirect_to :action => :index #告訴瀏覽器  HTTP code 303
	end	

	private
	#params是屬於白名單（正面表列），只有params裡面認定的才會接起來
	def event_params
		params.require(:event).permit( :name, :description)
	end	
end
