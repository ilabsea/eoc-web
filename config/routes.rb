Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'sops#index'

  namespace :api do
    namespace :v1 do
      resources :sops, only: [:index]
    end
  end

  resources :sops do
    collection do
      get :download
      get :upload
      post :import
    end
  end
end
