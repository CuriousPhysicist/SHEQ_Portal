Rails.application.routes.draw do

  ## For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  ## the syntax of the routes is 'HPPT verb' 'URL' to: 'controller#action'
  ## resources produce standard RESTful actions for :index, :new, :create, :edit, :update, :show, :destroy
  
  ## root sets the landing page.
  
  root 'sessions#landing_page'
  
  ## Sessions are not stored as a model but add a remember digest attribute to the User model
  
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  
  ## dashboard routes are available without loggin in...
  
  get     '/dashboard_actions', to: 'sessions#dashboard_actions'
  get     '/dashboard_events', to: 'sessions#dashboard_events'
  get     '/dashboard_documents', to: 'sessions#dashboard_documents'
  
  ## uploader route is only availble if logged in and admin user

  get	  '/uploader_options', to: 'sessions#uploader_options'

  ## User routes 
  
  resources :users, only: [:index, :edit, :update, :show, :destroy] do
    collection { post :import }
    collection { get :upload }
  end
  
  get '/activate', to: 'users#activate'
  get '/deactivation', to: 'users#comment'
  post '/deactivation', to: 'users#comment_submitted'
  
  get '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  
  ## Action routes
  
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
  
  ## Business logic routes for actions - these actions set or reset Boolean flags
  
  get '/reject', to: 'actions#reject'
  post '/reject', to: 'actions#reject_submitted'
  patch '/accepted', to: 'actions#accepted'
  
  ## Event routes
  
  resources :events do
    collection { get :options}
    collection { get :find }    ## enables finding of event by reference number rather than id (not possible through Javascript)
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
  
  ## Business logic routes for events - these actions set or reset Boolean flags
  
  patch '/acknowledged', to: 'events#acknowledged'
  
  ## Event reporting routes for none-logged-in users
  
  get '/guest', to: 'events#guest'
  post '/guest', to: 'events#create_guest'
  
  ## Author/Reviewer/Approver routes
  
  get 'author/new'        ## no views used for these three models
  get 'author/create'     ## cotroller will take action then return to either User or Approval_route views depending on context
  get 'author/destroy'

  get 'reviewer/new'
  get 'reviewer/create'
  get 'reviewer/destroy'
  
  get 'approver/new'
  get 'approver/create'
  get 'approver/destroy'
  
  ## Document routes
  
  resources :documents do
    collection { get :upissue }
    collection { get :upload }
    collection { post :import }
    collection { get :search }
    collection { get :tasks }
    collection { patch :reviewplease }
    collection { patch :reviewed }
    collection { patch :approveplease }
    collection { patch :approved}
end
  
  get 'documents/checkout'
  get 'documents/checkin'

  ## Approval_route routes
  
  get 'approval_route/new'
  get 'approval_route/create'
  get 'approval_route/edit'
  patch 'approval_route/update'
  get 'approval_route/show'
  get 'approval_route/close_route'
  
end
