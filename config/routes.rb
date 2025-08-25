Rails.application.routes.draw do
  devise_for :users

  root to: "users#index"

  resources :products do
    post :favorite, on: :member
    resource :order, only: [:new, :create]
  end
  
  resources :users, only: [:index, :show, :edit, :update]
  resources :cart_items, only: [:index, :create, :update, :destroy]
  resources :favorites, only: [:index, :create, :destroy]
  resources :orders, only: [:index, :show]
  

  
end
