Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  get 'events/created', to: 'events#created'
  get 'events/attending', to: 'events#attending'
  resources :events
  resources :friendships, :only => [:index, :create, :destroy]
  resources :friend_requests, :only => [:create, :index, :destroy]
  resources :users, :only => [:show]
  resources :invitations, :only => [:update, :create, :destroy]
  resources :attendances, :only => [:create, :destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "events#index"
end
