class CartController < ApplicationController
  before_action :authenticate_user!
  before_action :initialize_cart

  def add
    product = Product.find(params[:id])
    @cart << { id: product.id, name: product.name, price: product.price }
    session[:cart] = @cart
    redirect_to cart_path, notice: "#{product.name} added to cart"
  end

  def remove
    cart_item = CartItem.find_by(id: params[:id])
    if cart_item
      cart_item.destroy
      redirect_to cart_path, notice: "Product removed from cart."
    else
      redirect_to cart_path, alert: "Product not found in cart."
    end
  end

  def show
    if current_user && current_user.cart
      @cart_items = current_user.cart.cart_items.includes(:product)
    else
      @cart_items = []
      @cart.each do |item|
        product = Product.find_by(id: item[:id])
        @cart_items << CartItem.new(product:, quantity: item[:quantity]) if product
      end
    end
  end

  private

  def initialize_cart
    if current_user
      @cart = current_user.cart || current_user.create_cart
    else
      session[:cart] ||= []
      @cart = session[:cart]
    end
  end
end
