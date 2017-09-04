require 'sidekiq/web'
Rails.application.routes.draw do

  root 'dashboard#index'
  mount Sidekiq::Web, at: '/sidekiq'

  resources :searches
  resources :sessions
  resources :users do
    resources :photos
    resources :signatures
  end

  namespace :api do
    resources :sessions, only: %i(index)
    resources :searches, only: %i(create)
    resources :users, only: %i(create show) do
      resources :photos, only: %i(create show)
      resources :signatures, only: %i(create show)
      resources :session_histories, only: %i(create show)
    end
  end
end
