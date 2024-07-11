# app/helpers/application_helper.rb
module ApplicationHelper
  def breadcrumbs
    crumbs = []

    # Add home breadcrumb
    crumbs << link_to("Home", root_path)

    # Add additional breadcrumbs based on the current request
    if controller_name == "categories" && action_name == "show"
      # Example: For viewing a specific category
      category = Category.find(params[:id])
      crumbs << link_to(category.name, category_path(category))
    elsif controller_name == "products" && action_name == "show"
      # Example: For viewing a specific product
      product = Product.find(params[:id])
      # Add category breadcrumb if product is associated with a category
      crumbs << link_to(product.category.name, root_path) if product.category
      crumbs << link_to(product.name, product_path(product))

    end

    crumbs.join(" › ").html_safe
  end
end
