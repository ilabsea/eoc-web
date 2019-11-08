# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "categories#index"

  namespace :api do
    namespace :v1 do
      resources :categories, only: [:show]
      resources :sops, only: [:index]
      resources :tokens, only: [:create]
    end
  end

  # resources :sops, except: [:index] do
  resources :sops do
    collection do
      get :download
      get :upload
      post :import
    end
  end

  resources :categories do
    collection do
      post :move
      post :move_sop
    end
  end

  resources :searches, only: [:index]
end
