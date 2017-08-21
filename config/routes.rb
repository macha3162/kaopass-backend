require 'sidekiq/web'
Rails.application.routes.draw do
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
    end
  end
end
