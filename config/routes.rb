Rails.application.routes.draw do
  
  root 'profiles#show'
  get '/register' => 'profiles#new'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'
  post '/users/:profile_id' => 'user#create'

  get '/profiles/:profile_id/delivery', :to => "profiles#delivery"
  post '/profiles/:profile_id/delivery', :to => "profiles#update"

  # get 'profiles/:profile_id/confirmation' => "profiles#confirmation"

  resources :profiles do
    resources :users
  end

  resources :charges
  resources :profiles

  resources :sessions
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
