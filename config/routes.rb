Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root to: 'toppages#index'
  
  get 'signup', to: 'users#new'
  resources :users, only: [:show, :new, :create]

end
