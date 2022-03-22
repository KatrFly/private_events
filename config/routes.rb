Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  get 'events/created', to: 'events#created'
  get 'events/attending', to: 'events#attending'
  resources :events, :friendships, :friend_requests
  resources :users, :only => [:show, :index]
  resources :invitations, :only => [:update, :create, :destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "events#index"
end
