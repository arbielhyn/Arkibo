Rails.application.routes.draw do
  get 'cart/add'
  get 'cart/remove'
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
  resources :products, only: [:index, :show]
  resources :products, only: [:index, :show] do
    post 'add_to_cart', on: :member
  end

  resource :profile, only: [:show, :edit, :update]

  # Cart routes
  resource :cart, only: [:show] do
    delete 'cart/remove/:id', to: 'carts#remove', as: 'remove_from_cart'  # Route for removing from cart
  end

  # Routes for cart actions
  patch 'cart/update_quantity/:id', to: 'carts#update_quantity', as: 'update_cart_quantity'

  mount Ckeditor::Engine => '/ckeditor'

    # Routes for cart actions
    delete 'cart/remove/:id', to: 'carts#remove', as: 'remove_from_cart'
    get 'cart/show', to: 'carts#show', as: 'show_cart'

  # Route for handling 404 errors
  get '*path', to: 'application#render_404', via: :all
end
