Rails.application.routes.draw do
  devise_for :users

  root to: "users#index"

  resources :users, only: [:index, :show, :edit, :update]

  resources :products do
    # ← 競合の原因だった行は削除（post :favorite on: :member は使わない）
    resource :favorite, only: [:create, :destroy], controller: 'favorites' # /products/:product_id/favorite
    resource :orders, only: [:new, :create]
  end

  resources :favorites, only: [:index] # /favorites 一覧
  resources :cart_items, only: [:index, :create, :update, :destroy] do
    delete :clear, on: :collection
  end

  resources :orders, only: [:index, :show, :new]
end