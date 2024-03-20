Rails.application.routes.draw do
  resources :products, only: [ :index, :show ]
  resources :orders, only: [ :new, :create, :show ]
  resources :comments, only: [ :create ]

  root to: "products#index"
end
