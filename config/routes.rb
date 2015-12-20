Rails.application.routes.draw do

    devise_for :users, :controllers => { omniauth_callbacks: 'omniauth_callbacks' }

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
        get 'search' => :search, as: 'search'
        get ':path_name' => :show, as: 'show'
    end

    get 'locale/:name' => 'welcome#locale', as: 'change_locale'

    root to: 'catalog#index', as: 'catalog'
    match "*path", to: "application#catch_404", via: :all
end
