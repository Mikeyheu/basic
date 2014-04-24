Basic::Application.routes.draw do
  resources :users
  resources :images
  root 'users#index'
end
