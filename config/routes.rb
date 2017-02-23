Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  # the syntax of the routes is 'HPPT verb' 'URL' to: 'controller#action'
  # resources produce standard RESTful actions for :index, :new, :create, :edit, :update, :show, :destroy
  
  # root sets the landing page.
  
  root 'sessions#landing_page'
  
  # Sessions are not stored as a model but add a remember digest attribute to the User model
  
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  
  # dashboard routes are available without loggin in...
  
  get     '/dashboard_actions', to: 'sessions#dashboard_actions'
  get     '/dashboard_events', to: 'sessions#dashboard_events'
  
  # uploader route is only availble if logged in and admin user

  get	  '/uploader_options', to: 'sessions#uploader_options'

  # User routes 
  
  resources :users, only: [:index, :edit, :update, :show, :destroy] do
    collection { post :import }
    collection { get :upload }
  end
  
  get '/activate', to: 'users#activate'
  get '/deactivation', to: 'users#comment'
  post '/deactivation', to: 'users#comment_submitted'
  
  get '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  
  # Action routes
  
  resources :actions do
    collection { get :options}    # This block nests routes into the actions path
    collection { get :find }      # they are references actions_word_path
    collection { post :import}    
    collection { get :upload}
    collection { get :all}
    collection { get :owned}
    collection { get :team}
    collection { get :search}
    collection { get :tasks}
    collection { patch :extendplease}
    collection { patch :extend}
    collection { patch :closeplease}
    collection { patch :close}
  end
  
  # Business logic routes for actions - these actions set or reset Boolean flags
  
  
  get '/reject', to: 'actions#reject'
  post '/reject', to: 'actions#reject_submitted'
  patch '/accepted', to: 'actions#accepted'
  
  # Event routes
  
  resources :events do
    collection { get :options}
    collection { get :find }
    collection { get :tasks}
    collection { post :import }
    collection { get :upload }
    collection { get :raised}
    collection { get :all}
    collection { get :team}
    collection { get :search}
    collection { get :tasks}
    collection { patch :closeplease}
    collection { patch :close}
  end
  
  patch '/acknowledged', to: 'events#acknowledged'

  get '/guest', to: 'events#guest'
  post '/guest', to: 'events#create_guest'
  
end
