Rails.application.routes.draw do
  root "pages#home"

  resources :ideas, only: [:show, :create]

  namespace :api do
    namespace :v1 do
      resources :rolls, only: [:create]
    end
  end
end
