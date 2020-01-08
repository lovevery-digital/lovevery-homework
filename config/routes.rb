Rails.application.routes.draw do
  get 'registry/search'
  post 'registry/find'

  resources :products, only: [ :index, :show ]
  resources :orders, only: [ :new, :create, :show ]

  root to: "products#index"
end
