Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  
  get 'reservation/valider', to: 'reservations#valider'
  get 'reservation/confirm', to: 'reservations#create'
  get 'reservations/check', to: 'reservations#show'
  post 'reservations/check', to: 'reservations#show'

  get 'inquiry', to: 'inquiries#new'
  resources :users
  resources :reservations
  resources :inquiries
end
