class CartController < ApplicationController
  before_action :initialize_cart

  def add
    product = Product.find(params[:id])
    @cart << { id: product.id, name: product.name, price: product.price }
    session[:cart] = @cart
    redirect_to cart_path, notice: "#{product.name} added to cart"
  end

  def remove
    if current_user
      @cart_item = @cart.cart_items.find(params[:id])
      @cart_item.destroy
    else
      @cart.reject! { |item| item["id"] == params[:id].to_i }
      session[:cart] = @cart
    end

    respond_to do |format|
      format.html { redirect_to cart_path, notice: 'Product removed from cart.' }
      format.js   # This will look for a corresponding remove.js.erb file
    end
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
    if current_user
      @cart = current_user.cart || current_user.create_cart
    else
      session[:cart] ||= []
      @cart = session[:cart]
    end
end
end
