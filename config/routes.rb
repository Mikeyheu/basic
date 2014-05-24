Basic::Application.routes.draw do
  resources :users 
  resources :sites
  resources :images do
    collection do
      post 'check_processed'
    end
  end
  # root :to => "users#index", :constraints => { :domain => "trixstr.com" }
  root to: 'sites#show'  #, :constraints => { :subdomain => 'sites'} # this breaks the subdomains and custom domains
end
