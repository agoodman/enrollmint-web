InventoryKitWeb::Application.routes.draw do

  match '/sign_up' => 'users#new', :as => 'sign_up'
  match '/sign_in' => 'sessions#new', :as => 'sign_in'
  match '/sign_out' => 'sessions#destroy', :as => 'sign_out'
  resource :session, :only => [ :new, :create, :destroy ]
  
  resource :user, :only => [ :create, :show, :update, :destroy ]
  resources :products, :only => [ :index, :create, :show, :update, :destroy ]
  
  SECRET_KEY_REGEX = /[0-9a-fA-F]{10}/
  match '/customers/:secret_key' => 'customers#show', :via => :get, :secret_key => SECRET_KEY_REGEX
  match '/customers/:secret_key' => 'customers#update', :via => :put, :secret_key => SECRET_KEY_REGEX
  match '/subscriptions/:secret_key' => 'subscriptions#show', :via => :get, :secret_key => SECRET_KEY_REGEX
  match '/subscriptions/:secret_key' => 'subscriptions#update', :via => :put, :secret_key => SECRET_KEY_REGEX
  match '/products/:secret_key' => 'products#update', :via => :put, :secret_key => SECRET_KEY_REGEX

  resources :customers, :only => [ :index, :create, :show, :update ] do
    resources :subscriptions, :controller => 'customers/subscriptions', :only => [ :index, :create, :show, :update ]
    resources :receipts, :controller => 'customers/receipts', :only => [ :create ]
  end

  match '/features' => 'home#features', :as => 'features'
  root :to => 'home#index'
  
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
