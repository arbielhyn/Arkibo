class PagesController < ApplicationController
  def show
    @page = Page.find_by(title: params[:title].capitalize)
    if @page
      render :show
    else
      render file: "#{Rails.root}/public/404.html", status: :not_found
    end
  end
end
