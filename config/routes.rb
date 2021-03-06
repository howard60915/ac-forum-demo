Rails.application.routes.draw do


  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
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

  namespace :api do
      constraints(host: 'howard.localhost') do
        resources :users, only: [:index , :show] 
        root to: "base#index"
      end  
  end 	

  

  resources :people

  get "/ajax" => "welcome#ajax"
  get "/ajaxtest" => "welcome#ajaxtest"
	get "welcome/say_hello" => "welcome#say"
	get "welcome" => "welcome#index"
	# root "welcome#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  	
end
