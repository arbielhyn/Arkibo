ActiveAdmin.register Order do
  # Index page configuration
  index do
    selectable_column
    id_column
    column :user
    column :subtotal_amount do |order|
      number_to_currency(order.subtotal_amount)
    end
    column :tax_amount do |order|
      number_to_currency(order.tax_amount)
    end
    column :total_amount do |order|
      number_to_currency(order.total_amount)
    end
    column :created_at
    actions
  end

  # Show page configuration
  show do
    attributes_table do
      row :id
      row :user
      row :subtotal_amount do |order|
        number_to_currency(order.subtotal_amount)
      end
      row :tax_amount do |order|
        number_to_currency(order.tax_amount)
      end
      row :total_amount do |order|
        number_to_currency(order.total_amount)
      end
      row :created_at
      row :updated_at
    end
    panel "Order Details" do
      table_for order.order_items do
        column "Product" do |item|
          item.product.name
        end
        column "Quantity" do |item|
          item.quantity
        end
        column "Unit Price" do |item|
          number_to_currency(item.unit_price)
        end
        column "Total Price" do |item|
          number_to_currency(item.unit_price * item.quantity)
        end
      end
    end
  end
end
