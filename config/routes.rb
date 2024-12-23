Rails.application.routes.draw do
  resources :entries
  resources :timers, only: [:update]

  root "entries#index"
end
