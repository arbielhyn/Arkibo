class ProductsController < ApplicationController
  def index
    @categories = Category.all
    if params[:category_id]
      @category = Category.find(params[:category_id])
      @products = @category.products.page(params[:page]).order(created_at: :desc)
    else
      @products = Product.page(params[:page]).order(created_at: :desc)
    end
  end

  def show
    @product = Product.find(params[:id])
  end
end
