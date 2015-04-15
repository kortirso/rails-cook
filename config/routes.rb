Rails.application.routes.draw do

  get 'grades/show'

  get 'grades/create'

  resources :measures
  resources :ingridients
  resources :line_ingrids

  devise_for :users
  get 'contacts' => 'contacts#index', as: 'contacts'
  get 'welcome/index'

  resources :contacts
  resources :recipes
  resources :countries
  resources :categories
  resources :comments

  get 'catalog/index'
  get 'catalog/all'
  get 'catalog/category/:name' => 'catalog#category'
  get 'catalog/kitchen/:name' => 'catalog#kitchen'
  get 'catalog/show/:path_name' => 'catalog#show'

  get 'grade/:grade/user/:user_id/recipe/:recipe_id' => 'grades#create', as: 'grading'

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

  root to: 'catalog#index', as: 'catalog'
end
