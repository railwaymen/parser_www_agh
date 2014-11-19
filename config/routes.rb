Rails.application.routes.draw do
  resources :data_sources, only: [:index]
  resources :posts, only: [:create]
  root 'data_sources#index'
end
