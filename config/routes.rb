Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root 'sessions#dashboard'
  
  get '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get    '/error',   to: 'users#error'
  
  get '/actions/options', to: 'actions#options'
  patch '/closeplease', to: 'actions#closeplease'
  patch '/close', to: 'actions#close'
  get '/reject', to: 'actions#reject'
  post '/reject', to: 'actions#return'
  patch '/extendplease', to: 'actions#extendplease'
  patch '/extend', to: 'actions#extend'
  
  resources :users
  resources :actions do
    collection { post :import}
    collection { get :upload}
    collection { get :all}
    collection { get :owned}
    collection { get :created}
    collection { get :tasks}
    
  end
  
end
