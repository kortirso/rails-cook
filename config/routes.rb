Rails.application.routes.draw do

    devise_for :users, :controllers => { omniauth_callbacks: 'omniauth_callbacks' }

    get 'mark/:mark/recipe/:recipe_id' => 'grades#create', as: 'grading'
    get 'contacts' => 'contacts#index', as: 'contacts'
    get 'basket' => 'basket#show', as: 'basket'
    post 'positions/create' => 'positions#create', as: 'positions'

    resources :recipes, :countries, :categories, :measures, :ingridients
    resources :comments, only: :create

    scope controller: :carts do
        get 'carts/:id' => :show, as: 'cart'
        delete 'carts/:id' => :destroy
        post 'plus/:id' => :recipe_plus, as: 'plus'
        post 'minus/:id' => :recipe_minus, as: 'minus'
        post 'destroy/:id' => :recipe_destroy, as: 'destroy'
    end

    scope path: '/catalog', controller: :catalog do
        get 'index' => :index
        get 'all' => :all, as: 'catalog_all'
        get 'category/:name' => :category, as: 'type'
        get 'kitchen/:name' => :kitchen, as: 'kitchen'
        get 'search' => :search, as: 'search'
        get ':path_name' => :show, as: 'show'
    end

    get 'locale/:name' => 'application#locale', as: 'change_locale'
    get 'admin' => 'application#admin', as: 'admin'

    root to: 'catalog#index', as: 'catalog'
    match "*path", to: "application#catch_404", via: :all
end
