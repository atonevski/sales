Rails.application.routes.draw do

  namespace :admin do
    get 'roles/index'
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
  
  root 'games#index'

  resources :games, only: [ :index, :show, :edit, :update ] do 
    resources :categories
  end

  resources :agents, only: [ :index, :show, :edit, :update ] do 
    resources :terminals
  end

  get 'about'         =>  'static_pages#about'
  get 'todo'          =>  'static_pages#todo'
  get 'xml-terminals' =>  'static_pages#terminals', as: 'xml_terminals'
  get 'import-sales'  =>  'static_pages#import_sales', as: 'import_sales'

  # reports
  get 'annually-per-month-per-game/(:id)' =>
        'reports#annually_per_month_per_game', as: 'annually_per_month_per_game'
  get 'instants-annually-per-month-per-game/(:id)' =>
        'reports#instants_annually_per_month_per_game',
        as: 'instants_annually_per_month_per_game'
  get 'instants-general' => 'reports#instants_general', as: 'instants_general'
  get 'sales-per-city' => 'reports#sales_per_city', as: 'sales_per_city'

  resources :commissions, only: [ :index, :show, :new, :create ]
  resources :commission_letters, only: [:index]

  namespace :admin do
    root 'application#index'
    resources :games,  only: [ :new, :create, :destroy ]
    resources :agents, only: [ :new, :create, :destroy ]
    resources :users do
      member do
        patch :archive
      end
    end
    resources :roles
  end

  devise_for :users
end
