# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  # Other actions and configurations
  def render_404
    render file: "#{Rails.root.join('public/404.html')}", layout: false, status: :not_found
  end

  def initialize_guest_cart
    return unless !current_user && session[:cart_id].present?

    @current_cart = Cart.find_by(id: session[:cart_id])
  end

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: %i[username name email password password_confirmation
                                               street city postal_code province])
    devise_parameter_sanitizer.permit(:account_update,
                                      keys: %i[username name email street city postal_code province current_password password
                                               password_confirmation])
  end
end
