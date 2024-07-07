class ProductsController < ApplicationController
  def index
    @categories = Category.all
    @products = Product.page(params[:page]).order(created_at: :desc)
  end

  def show
    @product = Product.find(params[:id])
  end
end
