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

  resource :profile, only: [:show, :edit, :update]
  mount Ckeditor::Engine => '/ckeditor'

    # Routes for cart actions
    post 'cart/add/:id', to: 'cart#add', as: 'add_to_cart'
    patch 'cart/update_quantity/:id', to: 'cart#update_quantity', as: 'update_cart_quantity'
    delete 'cart/remove/:id', to: 'cart#remove', as: 'remove_from_cart'
    get 'cart', to: 'cart#show', as: 'cart'

  # Route for handling 404 errors
  get '*path', to: 'application#render_404', via: :all
end
