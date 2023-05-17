Rails.application.routes.draw do
  root "pages#home"

  resources :rolls, only: [:create]
end
