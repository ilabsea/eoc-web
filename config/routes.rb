# frozen_string_literal: true

require "sidekiq/web"

Rails.application.routes.draw do
  devise_for :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "categories#index"

  namespace :api do
    namespace :v1 do
      resources :categories, only: [:show]
      resources :sops, only: [:index, :show]
      resources :tokens, only: [:create]
    end
  end

  # resources :sops, except: [:index] do
  resources :sops do
    collection do
      get :download
    end
  end

  resources :categories do
    collection do
      post :move
      post :move_sop
    end
  end

  resources :searches, only: [:index]

  resources :uploads, only: [:index] do
    collection do
      post :validate
      post :import
    end
  end

  resource :users do
    collection do
      post :update_locale
    end
  end

  if Rails.env.production?
    authenticate :user, lambda { |u| u.admin? } do
      mount Sidekiq::Web => "/sidekiq"
    end
  else
    mount Sidekiq::Web => "/sidekiq"
  end
end
