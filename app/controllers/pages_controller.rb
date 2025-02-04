class PagesController < ApplicationController
  def show
    @page = Page.find_by(title: params[:title])
    if @page
      render :show
    else
      render file: "#{Rails.root.join('public/404.html')}", status: :not_found
    end
  end
end
