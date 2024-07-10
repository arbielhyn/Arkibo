class CartController < ApplicationController
  before_action :initialize_cart

  def add
    product = Product.find(params[:id])
    @cart << { id: product.id, name: product.name, price: product.price }
    session[:cart] = @cart
    redirect_to cart_path, notice: "#{product.name} added to cart"
  end

  def remove
    @cart_item = current_user.cart.cart_items.find_by(id: params[:id])
    if @cart_item
      @cart_item.destroy
      flash[:notice] = "Item removed from cart."
    else
      flash[:alert] = "Item not found in cart."
    end
    redirect_to cart_path
  end

  def show
    if current_user && current_user.cart
      @cart_items = current_user.cart.cart_items.includes(:product)
    else
      @cart_items = []
      @cart.each do |item|
        product = Product.find_by(id: item[:id])
        if product
          @cart_items << CartItem.new(product: product, quantity: item[:quantity])
        end
      end
    end
  end

  private

  def initialize_cart
    session[:cart] ||= []
    @cart = session[:cart]
  end
end
