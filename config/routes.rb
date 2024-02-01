Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  root 'main#home'

  resources :products

  resources :purchases

  resources :purchase_items, only: [:create, :update, :destroy]
end
