Rails.application.routes.draw do

  root 'profiles#show'
  get '/register' => 'profiles#new'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  resources :users, only: [:destroy, :create]
  post '/profiles/:profile_id/delivery' => 'profiles#update'

  # get '/profiles/:profile_id', :to => "profiles#hold"
  # post '/profiles/:profile_id/', :to => "profiles#hold"

  resources :profiles do
    member do
      put :hold
      get :delivery
    end
    resources :users
    resources :charges
  end

  # resources :charges
  # resources :profiles

  resources :sessions
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
