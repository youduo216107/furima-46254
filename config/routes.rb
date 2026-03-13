Rails.application.routes.draw do
  devise_for :users
  resources :items, only: [:new, :create, :index]
  root to: 'items#index'
  
end
