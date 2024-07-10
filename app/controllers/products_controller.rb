class ProductsController < ApplicationController
  def index
    @categories = Category.all
    if params[:on_sale]
      @products = Product.where(on_sale: true)
    elsif params[:new_products]
      @products = Product.where('created_at >= ?', 1.days.ago)
    elsif params[:recently_updated]
      @products = Product.where('updated_at >= ?', 1.days.ago)
    else
      @products = Product.all
    end

    if params[:keyword].present?
      @products = @products.where("name LIKE ? OR description LIKE ?", "%#{params[:keyword]}%", "%#{params[:keyword]}%")
    end

    if params[:category_id].present? && params[:category_id].to_i != 0
      @products = @products.where(category_id: params[:category_id])
    end

    @products = @products.page(params[:page]).order(created_at: :desc)
  end

  def show
    @product = Product.find(params[:id])
  end
end
