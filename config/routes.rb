Rails.application.routes.draw do

	devise_for :users
	get 'mark/:mark/recipe/:recipe_id' => 'grades#create', as: 'grading'
	get 'contacts' => 'contacts#index', as: 'contacts'
	get 'basket' => 'basket#show', as: 'basket'
	get 'welcome/index'
	post 'positions/create' => 'positions#create', as: 'positions'

	resources :recipes, :countries, :categories, :comments, :measures, :ingridients

	scope controller: :carts do
		get 'carts/:id' => :show, as: 'cart'
		delete 'carts/:id' => :destroy
		post 'plus/:position' => :recipe_plus, as: 'plus'
		post 'minus/:position' => :recipe_minus, as: 'minus'
	end

	scope path: '/catalog', controller: :catalog do
		get 'index' => :index
		get 'all' => :all, as: 'catalog_all'
		get 'category/:name' => :category, as: 'type'
		get 'kitchen/:name' => :kitchen, as: 'kitchen'
		get ':path_name' => :show, as: 'show'
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

	root to: 'catalog#index', as: 'catalog'
	match "*path", to: "application#catch_404", via: :all
end
