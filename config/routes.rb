Rails.application.routes.draw do

  devise_for :users
  root to: "home#index"

  resources :meetings, only: [:index, :new, :create, :show]
end
