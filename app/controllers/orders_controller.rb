class OrdersController < ApplicationController
  def checkout
    @order = current_user.orders.build
    @cart_items = current_user.cart.cart_items.includes(:product)

    # Calculate total amount including taxes
    subtotal = @cart_items.sum { |item| item.quantity * item.product.price }
    province = current_user.province

    # Fetch tax rates for the province
    tax_rates = Tax.where(province:).first

    @order.total_amount = calculate_total(subtotal, tax_rates)

    # Build order items
    @cart_items.each do |cart_item|
      @order.order_items.build(
        product:    cart_item.product,
        quantity:   cart_item.quantity,
        unit_price: cart_item.product.price
      )
    end

    # Prepare to save the order
    if @order.save
      # Clear the cart after successful checkout
      current_user.cart.cart_items.destroy_all

      # Redirect to order confirmation or invoice display
      redirect_to order_path(@order)
    else
      # Handle errors if save fails
      flash[:error] = "Failed to create order"
      render :checkout # or render the checkout form again
    end
  end

  private

  def calculate_total(subtotal, tax_rates)
    return subtotal if tax_rates.blank?

    total = subtotal
    total += subtotal * (tax_rates.pst / 100) if tax_rates.pst.present?
    total += subtotal * (tax_rates.gst / 100) if tax_rates.gst.present?
    total += subtotal * (tax_rates.hst / 100) if tax_rates.hst.present?

    total.round(2)
  end
end
