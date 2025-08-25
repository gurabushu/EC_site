Rails.application.routes.draw do
  devise_for :users

  root to: "users#index"

  resources :products
  resources :users, only: [:index, :show, :edit, :update]
  

  
end
