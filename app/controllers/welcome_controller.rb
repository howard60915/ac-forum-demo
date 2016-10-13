class WelcomeController < ApplicationController
		
	def index
			#GET/welcome
	end	

		#GET/welcome/say_hello
	def say

		# view/welcome/say.html.erb
	end	

	def ajaxtest
      respond_to do |format|
        format.html { render :layout => false } # ajaxtest.html.erb
        format.json {
          render :json => { :title => Time.now , 'picture' => 'https://scontent-tpe1-1.xx.fbcdn.net/v/t34.0-12/14628089_1542094655816386_461788604_n.jpg?oh=5a920f4cfd408cb0c5c9817117dc9669&oe=5801E89F'}
        }
        format.js  
      end
  
    end

end
