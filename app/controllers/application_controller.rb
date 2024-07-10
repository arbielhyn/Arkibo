# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  # Other actions and configurations
  before_action :authenticate_user!
  def render_404
    render file: "#{Rails.root}/public/404.html", layout: false, status: :not_found
  end
  def initialize_guest_cart
    if !current_user && session[:cart_id].present?
      @current_cart = Cart.find_by(id: session[:cart_id])
    end
  end
end
