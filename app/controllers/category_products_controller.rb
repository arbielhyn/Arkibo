# app/controllers/category_products_controller.rb
class CategoryProductsController < ApplicationController
  def index
    @category = Category.find(params[:category_id])
    @products = @category.products
  end
end
