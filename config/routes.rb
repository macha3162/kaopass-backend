require 'sidekiq/web'
Rails.application.routes.draw do
  resources :sessions
  root 'dashboard#index'

  mount Sidekiq::Web, at: "/sidekiq"

  #root 'users#index'

  resources :searches
  resources :users do
    resources :photos
    resources :signatures
  end

  namespace :api do
    resources :searches
    resources :users do
      resources :photos
      resources :signatures
      resources :session_histories
    end
  end
end
