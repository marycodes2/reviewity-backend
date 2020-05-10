Rails.application.routes.draw do
  # devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'home#index'

  namespace :api do
    namespace :v1 do
      resources :posts, only: %i[create index destroy]
      resources :users, only: :create
      resources :sessions, only: %i[create]

      get 'sessions/auto_login', to: 'sessions#auto_login'
    end
  end
end
