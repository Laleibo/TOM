Rails.application.routes.draw do

  root 'profiles#show'
  get '/register' => 'profiles#new'
  post '/register' => 'profiles#show'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  post '/use_form' => 'users#ajax'

  resources :users, only: [:destroy, :create]
  post '/profiles/:profile_id/delivery' => 'profiles#update'

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


  resources :sessions

end
