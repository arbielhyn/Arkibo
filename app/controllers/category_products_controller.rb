# app/controllers/category_products_controller.rb
class CategoryProductsController < ApplicationController
  def index
    @category = Category.find(params[:category_id])
    @products = @category.products
  end

  def show
    @category = Category.find(params[:id])
    # Additional logic as needed
  end
end
