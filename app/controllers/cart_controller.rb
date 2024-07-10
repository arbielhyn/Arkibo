class CartController < ApplicationController
  before_action :initialize_cart

  def add
    product = Product.find(params[:id])
    @cart << { id: product.id, name: product.name, price: product.price }
    session[:cart] = @cart
    redirect_to cart_path, notice: "#{product.name} added to cart"
  end


  def remove
    product_id = params[:id].to_i
    @cart.delete_if { |item| item[:id] == product_id }
    session[:cart] = @cart
    redirect_to cart_path, notice: "Product removed from cart"
  end

  def show
    @cart_total = @cart.sum { |item| item[:price].to_f }
    Rails.logger.debug "Cart contents: #{@cart}"
  end

  private

  def initialize_cart
    session[:cart] ||= []
    @cart = session[:cart]
  end
end
