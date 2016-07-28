Rails.application.routes.draw do
  root 'sessions#index'
  get 'sessions/new'

  resources :profiles
  resources :sessions
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
