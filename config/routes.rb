Rails.application.routes.draw do
  root "games#index"

  resources :games, only: [:index, :show]

  resources :ideas, only: [:show, :create]

  namespace :api do
    namespace :v1 do
      resources :rolls, only: [:create]
    end
    namespace :v2 do
      resources :games, only: [:show] do
        resources :rolls, only: [:create]
      end
    end
  end

  get "raspi/shutdown", to: "raspi#shutdown"
end
