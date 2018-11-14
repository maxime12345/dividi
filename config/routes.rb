# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { confirmations: 'confirmations' }

  scope '(:locale)', locale: /fr|en/ do
    root to: 'pages#home'

    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

    resources :collections, only: %i[index show create edit update destroy]

    resources :items, only: %i[index show new create destroy edit update] do
      resources :reminders, only: %i[new create] do
        collection do
          get :new_outside
          post :create_outside
        end
      end
    end

    resources :reminders, only: %i[destroy index] do
      collection do
        get :new_item_outside
        post :create_item_outside
      end
      member do
        get 'accept', to: 'reminders#accept'
        delete 'decline', to: 'reminders#decline'
      end
    end

    resources :network_users, only: %i[index destroy] do
      member do
        get :accept
        delete :destroy_all_links
      end
    end

    resources :networks, only: %i[show update] do
      resources :network_users, only: :create
    end
    get 'pages/dashboard', to: 'pages#dashboard'
    get 'pages/dashboard_admin', to: 'pages#dashboard_admin'
    get 'pages/:token', to: 'pages#user_page', as: :user_page
  end
end
