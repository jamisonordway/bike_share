Rails.application.routes.draw do
  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  delete '/logout', to: "sessions#destroy"
<<<<<<< HEAD
  get '/dashboard', to: "users#show"
  get "/:station-name", to: redirect("/%{station-name}")
  root "homepages#index"

  resources :stations
  resources :users, only: [:new, :create, :show, :index]
=======

  get '/dashboard', to: 'users#show'

  root "homepages#index"

  resources :users, only: [:new, :create]

  resources :stations, except: [:show]
  
>>>>>>> Implementation of issue 13, admin show station, also implements visitor station show
  resources :trips, only: [:show, :index]
  
  namespace :admin do
    resources :stations
    resources :trips
  end
  
  resources :orders, only: [:new, :create, :show]
  
  get '/bike-shop', to: 'items#index'
  
  resources :items, only: [:show]
  
  get '/cart', to: "cart#index"
  patch '/bike-shop', to: "cart#update"
  delete '/bike-shop', to: 'cart#destroy'
  
  resources :stations, only: [:show], path: ''
  
  match '*path', to: 'unknowns#index', via: :all
end
