Rails.application.routes.draw do
  resources :entries
  resources :timers, only: [ :show, :update ]

  root "entries#index"
end
