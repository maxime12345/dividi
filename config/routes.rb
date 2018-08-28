Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # resources :collection, only: [] do
  #   resources :items, only: :create
  # end

  resources :items, only: [:index, :show, :new, :create]

end
