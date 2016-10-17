class EventsController < ApplicationController
	
	before_action :authenticate_user!, :except => [:index]
	before_action :set_event, :only => [:show, :edit, :update, :destroy, :dashboard]
	#GET/events/index
	#GET/events
	def index
		# if params[:group]
		# 	@group = Group.find_by_name(params[:group])
		# 	@events = @group.events.page(params[:page]).per(5)
		# else
		# 	@events = Event.page(params[:page]).per(5)
		# end
		#  以Group的名字進行排序之語法	

		if params[:keyword]
			@events = Event.where( [ "name like ?", "%#{params[:keyword]}%" ] )
		else
			@events = Event.all
		end	

		if params[:order]
			sort_by = (params[:order] == 'name') ? 'name' : 'id'
			@events = @events.order(sort_by)
		end	
		@events = @events.page(params[:page]).per(15)

		# respond_to do |format|
		# 	format.html
		# 	format.xml {
		# 		render :xml => @events.to_xml
		# 	}
		# 	format.json {
		# 		render :json => @events.to_json
		# 	}
		# 	format.atom {
		# 		@feed_title = "My Event List"
		# 	}#index.stom.builder
		# end	
		
		if params[:id]
			@event = Event.find(params[:id]) 
		else	
			@event = Event.new
		end
	end		

	#GET/events/new，因為是新生成，所以name & description內都是空的
	def new
		@event = Event.new
	end	
	#GET events/show/:id，因為是用find method，所以name & description會有原先event的資料
	def show
		@page_title = @event.name

		result = {id: @event.id, name: @event.name, created_at: @event.created_at}

         respond_to do |format|
		    format.html { @page_title = @event.name } # show.html.erb
		    format.xml # show.xml.builder
		    format.json { render :json => result.to_json }
		  end
        
	end	

	def dashboard
	end

	def latest
	  @events = Event.order("id DESC").limit(3)
	end

	#GET events/edit/:id
	def edit

	end	

	def update
		@event.user = current_user
		if params[:remove_upload_file] == "1"
			@event.logo = nil
		end

	  	if @event.update(event_params)#render會導向一個畫面或format

	  		flash[:notice] = "編輯成功"

	   	redirect_to event_path(@event) #到show頁面時，還是要給一個id，show才能找到更新的資料
		
		else 
			flash[:alert] = "編輯失敗"
		    render :action => :edit #"edit"
		end    	
	end

	def destroy
		@event.destroy

		flash[:alert] = "刪除成功"

	  redirect_to events_path
	end

	def bulk_update
		ids = Array(params[:ids])
		events = ids.map{|e| Event.find_by_id(e)}.compact

		if params[:commit] == "Delete"
			events.each {|e| e.destroy}
		elsif params[:commit] == "Publish"
			events.each {|e| e.update(:status => "published")}
		end

		redirect_to events_path
	end

	#POST/events/create
	def create
		@event = Event.new( event_params )
		@events = Event.page(params[:page]).per(15) #因為create在失敗的時候，並沒有送出@events的直，所以必須在失敗時給予@events可送出的直
		@event.user = current_user
		if @event.save

			flash[:notice] = "新增成功"
			
			redirect_to events_url #告訴瀏覽器  HTTP code 303
		else
			flash[:alert] = "新增失敗"
			render :action => :index #new.html.erb
		end	
	end	

	private

	def set_event
		@event = Event.find(params[:id])
	end	
	#params是屬於白名單（正面表列），只有params裡面認定的才會接起來
	def event_params
		params.require(:event).permit( :name, :description, :logo , :user_id ,  :category_id, :group_ids => []  )
	end	
end	




