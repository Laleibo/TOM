Rails.application.routes.draw do
  root 'sessions#index'
  get '/register' => 'profiles#new'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'
  post '/users/:profile_id' => 'user#create'

  resources :profiles do
    resources :users
  end

  resources :charges
  resources :profiles

  resources :sessions
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
