Rails.application.routes.draw do
  # devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'home#index'

  namespace :api do
    namespace :v1 do
      resources :users, only: :create
      resources :newsfeeds, only: :index
      resources :sessions, only: %i[create destroy]
    end
  end
end
