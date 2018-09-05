Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :collections, only: [:index, :show, :create, :edit, :update, :destroy]


  # resources :items, only: [:index, :show, :new, :create, :destroy] do
  #   resources :reminders, only: [:new, :create]

  resources :items, only: [:index, :show, :new, :create, :destroy] do
    resources :reminders, only: [:new, :create] do
      collection do
        get :new_outside
        post :create_outside
      end
    end
  end

  resources :reminders, only: :destroy do
    collection do
      get :new_item_outside
      post :create_item_outside
    end
  end

  resources :network_users, only: [:index, :show, :destroy] do
    member do
      get :accept
      delete :destroy_all_links
    end
  end

  resources :networks, only: [:show, :update] do
    resources :network_users, only: :create
    member do
      get :add_somebody_in_network
      post :update_somebody_in_network
    end

  end

  get '/pages/:token', to: 'pages#user_page', as: :user_page


end

