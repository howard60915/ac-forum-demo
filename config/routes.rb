Rails.application.routes.draw do


  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  
  post '/friendships/:friend_id' , :to => 'friendships#create' , as: 'add_friend'
  post '/friendships/:friend_id/accept' , :to => 'friendships#accept' , as: 'accept_friend'
  delete '/friendships/:friend_id' , :to => 'friendships#destroy' , as: 'unfriend'

  resources :events do 
  		resources :attendees , :controller => :event_attendees

  		collection do
  			get :latest
  			post :bulk_update
  		end

  		member do 
  			get :dashboard
  		end	 


  end
  namespace :admin do 
  		resources :events
  end	

  

  resources :people

  get "/ajax" => "welcome#ajax"
  get "/ajaxtest" => "welcome#ajaxtest"
	get "welcome/say_hello" => "welcome#say"
	get "welcome" => "welcome#index"
	root "users#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  	
end
