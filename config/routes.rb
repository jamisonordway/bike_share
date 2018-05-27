Rails.application.routes.draw do
  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  delete '/logout', to: "sessions#destroy"
  root "homepages#index"

  resources :users, only: [:new, :create, :index, :show]

  resources :stations

  resources :stations, shallow: true do
    resources :trips, only: [:show]
  end

  resources :items, only: [:index, :show]

  get '/cart', to: "cart#index"
  patch '/bike-shop', to: "cart#update"
end
