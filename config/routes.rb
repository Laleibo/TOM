Rails.application.routes.draw do

  root 'profiles#show'
  get '/register' => 'profiles#new'
  post '/register' => 'profiles#show'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  post '/use_form' => 'users#ajax'

  # get  '/_form', to: 'controller_profiles#show'
  # post '/_form', to: 'controller_profiles#show'

  resources :users, only: [:destroy, :create]
  post '/profiles/:profile_id/delivery' => 'profiles#update'

  # get '/profiles/:profile_id', :to => "profiles#hold"
  # post '/profiles/:profile_id/', :to => "profiles#hold"

  resources :profiles do
    member do
      get :confirm_email
      put :hold
      get :delivery
      get :invoice
    end

    resources :users
    resources :charges, only: [:create, :update] do
      collection do
        put :cancel
      end
    end
  end

  # resources :charges
  # resources :profiles

  resources :sessions
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
