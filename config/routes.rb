Basic::Application.routes.draw do
  resources :users 
  resources :sites
  resources :images do
    collection do
      post 'check_processed'
    end
  end
  root to: 'sites#show' # , :constraints => { :subdomain => 'app'}
  # root to: 'sites#index'
end
