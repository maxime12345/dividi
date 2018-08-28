Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :items, only: [:index, :show, :new, :create]
  resources :items, only: [:index, :show]
  resources :reminders, only: :index

end
