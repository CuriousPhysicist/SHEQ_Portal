Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  # the syntax of the routes is 'HPPT verb' 'URL' to: 'controller#action'
  # resources produce standard RESTful actions for :index, :new, :create, :edit, :update, :show, :destroy
  
  # root sets the landing page.
  
  root 'sessions#dashboard'
  
  # Sessions are not stored as a model but add a remember digest attribute to the User model
  
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  
  # User routes 
  
  resources :users, only: [:index, :edit, :update, :show, :destroy]
  
  get '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  
  # this route is only for development, remove requirement for full production
  get    '/error',   to: 'users#error'
  
  # Action routes
  
  resources :actions do
    collection { get :options}    # This block nests routes into the actions path
    collection { post :import}    # they are references actions_word_path
    collection { get :upload}
    collection { get :all}
    collection { get :owned}
    collection { get :created}
    collection { get :tasks}
  end
  
  # Business logic routes for actions - these actions set or reset Boolean flags
  
  patch '/closeplease', to: 'actions#closeplease'
  patch '/close', to: 'actions#close'
  get '/reject', to: 'actions#reject'
  post '/reject', to: 'actions#return'
  patch '/extendplease', to: 'actions#extendplease'
  patch '/extend', to: 'actions#extend'
  
  # Event routes
  
  resources :events do
    collection { get :options}
    collection { get :tasks}
  end
  
end
