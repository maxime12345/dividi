Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :collections, only: [:index, :show, :new, :create]

  resources :items, only: [:index, :show, :new, :create] do
    resources :reminders, only: [:new, :create]
  end

  resources :reminders, only: :destroy

  resources :network_users, only: [:index, :show, :destroy] do
    member do
      get :accept
    end
  end

  resources :networks, only: :show do
    resources :network_users, only: :create
  end


end

