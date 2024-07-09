Rails.application.routes.draw do
  get 'about', to: 'pages#show', defaults: { title: 'About' }
  get 'contact', to: 'pages#show', defaults: { title: 'Contact' }
  root to: 'products#index'

  # Categories routes with nested category_products
  resources :categories, only: [:index, :show] do
    resources :category_products, only: [:index], as: :products
  end

    # ActiveAdmin routes
    devise_for :admin_users, ActiveAdmin::Devise.config
    ActiveAdmin.routes(self)
  # Products routes
  resources :products, only: [:index, :show]

  mount Ckeditor::Engine => '/ckeditor'

  # Route for handling 404 errors
  get '*path', to: 'application#render_404', via: :all
end
