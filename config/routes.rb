Rails.application.routes.draw do
  get 'cart/add'
  get 'cart/show'
  get 'profiles/show'
  get 'profiles/edit'
  get 'profiles/update'
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # Your other routes here

  get 'about', to: 'pages#show', defaults: { title: 'About' }
  get 'contact', to: 'pages#show', defaults: { title: 'Contact' }
  root 'products#index'

  # Categories routes with nested category_products
  resources :categories, only: [:index, :show] do
    resources :category_products, only: [:index], as: :products
  end

  # Products routes
  resources :products, only: [:index, :show] do
    post 'add_to_cart', on: :member
  end

  resource :profile, only: [:show, :edit, :update]

  # Cart routes
  resource :cart, only: [:show] do
    get 'show', to: 'carts#show'  # Route for showing cart
  end
  # Cart routes
  resource :cart, only: [:show] do
    delete 'remove/:id', to: 'cart#remove_item', as: 'remove_item'
  end

  # Routes for cart actions
  patch 'cart/update_quantity/:id', to: 'carts#update_quantity', as: 'update_cart_quantity'

    # Order Routes
    resources :orders, only: [:new, :create] do
      collection do
        get 'checkout', to: 'orders#checkout', as: 'checkout'
        post 'checkout', to: 'orders#create'
      end
      member do
        get 'invoice', to: 'orders#show', as: 'invoice'
        get 'confirmation'
      end
    end


    resources :users do
      get 'profile', on: :collection  # Maps /users/profile to UsersController#profile
    end

    # Routes for cart actions
    get 'cart/show', to: 'carts#show', as: 'show_cart'

  # Route for handling 404 errors
  get '*path', to: 'application#render_404', via: :all
end
