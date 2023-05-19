Rails.application.routes.draw do
  root "pages#home"

  resources :rolls, only: [:create]
  resources :ideas, only: [:show, :create]
end
