class OrdersController < ApplicationController
  def index
    @orders = current_user.orders.includes(:order_items)
  end

  def show
    @order = Order.find(params[:id])
  end

  def checkout
    @order = current_user.orders.build
    @cart_items = current_user.cart.cart_items.includes(:product)

    @subtotal = calculate_subtotal(@cart_items)
    tax_rates = Tax.find_by(province: current_user.province)
    Rails.logger.debug "Subtotal: #{@subtotal}"
    Rails.logger.debug "Tax rates: #{tax_rates.inspect}"
    # Calculate total_amount using the Order model's methods
    tax_amount = @order.tax_amount # Call the tax_amount method from the Order model
    total_amount = @order.total_amount # Call the total_amount method from the Order model
    Rails.logger.debug "Tax Amount: #{tax_amount}"
    Rails.logger.debug "Total Amount: #{total_amount}"
    @cart_items.each do |cart_item|
      @order.order_items.build(
        product:    cart_item.product,
        quantity:   cart_item.quantity,
        unit_price: cart_item.product.price
      )
    end

    @order.status = "pending"
    @order.created_at = Time.current

    render :checkout
  end

  def create
    @order = current_user.orders.build(order_params)
    @order.status = "pending" # Ensure status is set
    @order.created_at = Time.now

    if @order.save
      current_user.cart.cart_items.destroy_all
      redirect_to confirmation_order_path(@order)
    else
      flash[:error] = @order.errors.full_messages.join(", ")
      Rails.logger.debug { @order.errors.full_messages.join(", ") }
      render :checkout
    end
  end

  def confirmation
    @order = Order.find(params[:id])
  end

  private

  def calculate_subtotal(cart_items)
    cart_items.sum { |item| item.quantity * item.product.price }
  end

  def calculate_total(subtotal, tax_rates)
    return subtotal if tax_rates.blank?

    total = subtotal
    total += subtotal * (tax_rates.pst / 100) if tax_rates.pst.present?
    total += subtotal * (tax_rates.gst / 100) if tax_rates.gst.present?
    total += subtotal * (tax_rates.hst / 100) if tax_rates.hst.present?

    total.round(2)
  end

  def order_params
    params.require(:order).permit(
      :total_amount,
      order_items_attributes: %i[product_id quantity unit_price]
    )
  end
end
