Basic::Application.routes.draw do
  resources :users 
  resources :images do
    collection do
      post 'check_processed'
    end
  end
  root 'users#index'
end
