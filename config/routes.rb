Rails.application.routes.draw do

  root 'profiles#show'
  get '/register' => 'profiles#new'
  post '/register' => 'profiles#show'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  # get '/user_form' => 'users#update'
  post '/user_form/:id' => 'users#ajax'
  get '/new_form/:id' => 'users#edit'
  get '/profiles/:id/del' => 'profiles#delivery'
  get '/profiles/:id/orders' => 'profiles#invoice'
  resources :users
  # post '/add_address' => 'profiles#address'

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
