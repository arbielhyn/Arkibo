# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  # Other actions and configurations

  def after_sign_out_path_for(resource_or_scope)
    root_path # Customize the path as needed
  end

  def render_404
    render file: "#{Rails.root}/public/404.html", layout: false, status: :not_found
  end
end
