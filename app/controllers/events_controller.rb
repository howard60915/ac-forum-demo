class EventsController < ApplicationController
	
	before_action :set_event, :only => [:show, :edit, :update, :destroy]
	#GET/events/index
	#GET/events
	def index
		@events = Event.page(params[:page]).per(15)

		respond_to do |format|
			format.html
			format.xml {
				render :xml => @events.to_xml
			}
			format.json {
				render :xml => @events.to_json
			}
			format.atom {
				@feed_title = "My Event List"
			}#index.stom.builder

		end	



	end	
	#GET/events/new，因為是新生成，所以name & description內都是空的
	def new
		@event = Event.new
	end	
	#GET events/show/:id，因為是用find method，所以name & description會有原先event的資料
	def show
		@page_title = @event.name

         respond_to do |format|
		    format.html { @page_title = @event.name } # show.html.erb
		    format.xml # show.xml.builder
		    format.json { render :json => { id: @event.id, name: @event.name, created_at: @event.created_at }.to_json }
		  end
        
	end	
	#GET events/edit/:id
	def edit
	end	

	def update
	  	if @event.update(event_params)

	  		flash[:notice] = "編輯成功"

	   		redirect_to event_url(@event) #到show頁面時，還是腰給一個id，show才能找到更新的資料
		
		else 
		    render :action => :edit
		end    	
	end

	def destroy
		@event.destroy

		flash[:alert] = "刪除成功"

	  redirect_to event_url
	end

	#POST/events/create
	def create
		@event = Event.new( event_params )
		if @event.save

			flash[:notice] = "新增成功"
			
			redirect_to events_url #告訴瀏覽器  HTTP code 303
		else
			render :action => :new #new.html.erb
		end	
	end	

	private

	def set_event
		@event = Event.find(params[:id])
	end	
	#params是屬於白名單（正面表列），只有params裡面認定的才會接起來
	def event_params
		params.require(:event).permit( :name, :description)
	end	
end
