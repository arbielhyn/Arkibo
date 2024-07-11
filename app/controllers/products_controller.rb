class ProductsController < ApplicationController
  def index
    @categories = Category.all

    @products = if params[:on_sale]
                  Product.where(on_sale: true)
                elsif params[:new_products]
                  Product.where("created_at >= ?", 1.day.ago)
                elsif params[:recently_updated]
                  Product.where("updated_at >= ?", 1.day.ago)
                else
                  Product.all
                end

    def add_to_cart
      @product = Product.find(params[:product_id])
      @cart = current_user.cart || current_user.create_cart
      @cart_item = @cart.cart_items.find_or_initialize_by(product_id: @product.id)

      if @cart_item.new_record?
        @cart_item.quantity = 1 # Initialize quantity if it's a new record
        @cart_item.save
        flash[:notice] = "#{@product.name} added to cart."
      elsif @cart_item.quantity == 1
        # Check if the cart item already exists with quantity 1
        flash[:alert] = "You can only have 1 item of this product."
      else
        @cart_item.update(quantity: 1) # Set quantity to 1 if it's more than 1
        flash[:notice] = "#{@product.name} quantity updated in cart."
      end

      redirect_to product_path(@product)
    end

    if params[:keyword].present?
      @products = @products.where("name LIKE ? OR description LIKE ?", "%#{params[:keyword]}%",
                                  "%#{params[:keyword]}%")
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
