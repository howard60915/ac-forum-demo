class Api::BaseController < ApplicationController
	skip_before_action :verify_authenticity_token
	before_action :enabled_cors
	before_action :set_default_format
	# before_action :authorize_header_token
	def index
		# data = {
		# 	ok: "123"
		# }
		# render({ json: data, status: 404 })
		response.headers['last-Modified']= Time.now.to_s
		@user = User.last
    	respond_to do |format|
    		format.html {render text: "xxxxx"}
    		format.json	{render json: @user  }
    	end	
    	# render json: @user
	end


	private

	  def enabled_cors
	    headers['Access-Control-Allow-Origin'] = '*'
	    headers['Access-Control-Allow-Methods'] = 'GET, POST, PUT, DELETE'
	    headers['Access-Control-Allow-Headers'] = 'Origin, X-Atmosphere-tracking-id, X-Atmosphere-Framework, X-Cache-Date, Content-Type, X-Atmosphere-Transport, X-Remote, api_key, auth_token, *'
	    headers['Access-Control-Request-Method'] = 'GET, POST, PUT, DELETE'
	    headers['Access-Control-Request-Headers'] = 'Origin, X-Atmosphere-tracking-id, X-Atmosphere-Framework, X-Cache-Date, Content-Type, X-Atmosphere-Transport,  X-Remote, api_key, *'
	  end

	  def set_default_format
	    request.format = 'json'
	  end

	  def authorize_header_token
	    if request.headers['X-TOKEN'] != '1234'
	       respond_error
	    end   
	  end

	  def respond_error
	  	render json: { error: true} , status: 403
	  end


end

