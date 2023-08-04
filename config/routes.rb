Rails.application.routes.draw do
  root "pages#home"

  resources :games, only: [:index, :show, :new, :create]

  resources :ideas, only: [:show, :create]

  namespace :api do
    namespace :v1 do
      resources :rolls, only: [:create]
    end
  end
end
