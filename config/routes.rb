Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  root 'main#home'

  resources :products

  resources :purchases do
    member do
      post 'register_sale'
      get 'download'
      get 'preview'
    end
  end

  resources :purchase_items, only: [:create, :update, :destroy]
end
