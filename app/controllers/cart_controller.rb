class CartController < ApplicationController
  before_action :authenticate_user!
  before_action :initialize_cart

  def add
    product = Product.find(params[:id])
    if current_user
      cart_item = current_user.cart.cart_items.find_or_initialize_by(product:)
      cart_item.quantity ||= 0
      cart_item.quantity += 1
      cart_item.save
    else
      existing_item = @cart.find { |item| item[:id] == product.id }
      if existing_item
        existing_item[:quantity] += 1
      else
        @cart << { id: product.id, name: product.name, price: product.price, quantity: 1 }
      end
      session[:cart] = @cart
    end
    redirect_to cart_path, notice: "#{product.name} added to cart"
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

  def remove_item
    if current_user && current_user.cart
      cart_item = current_user.cart.cart_items.find(params[:id])
      cart_item.destroy
    else
      @cart.reject! { |item| item[:id] == params[:id].to_i }
      session[:cart] = @cart
    end
    redirect_to cart_path, notice: "Item successfully removed from your cart."
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
