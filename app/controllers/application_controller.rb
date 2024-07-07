# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  # Other actions and configurations

  def render_404
    render file: "#{Rails.root}/public/404.html", layout: false, status: :not_found
  end
end
