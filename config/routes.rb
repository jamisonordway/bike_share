Rails.application.routes.draw do

  resources :stations
  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  delete '/logout', to: "sessions#destroy"
  get "/:station-name", to: redirect("/%{station-name}")
  root "homepages#index"
  resources :users, only: [:new, :create, :show, :index]

  resources :stations, shallow: true do
    resources :trips, only: [:show, :index]
  end

end
