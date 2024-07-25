ActiveAdmin.register Order do
  # Permitted parameters
  permit_params :user_id, :status, :total_amount, order_items_attributes: [:id, :product_id, :quantity, :unit_price, :_destroy]

  # Index page configuration
  index do
    selectable_column
    id_column
    column :user
    column :status
    column :subtotal_amount do |order|
      number_to_currency(order.subtotal_amount)
    end
    column :pst_amount do |order|
      number_to_currency(order.pst_amount)
    end
    column :gst_amount do |order|
      number_to_currency(order.gst_amount)
    end
    column :hst_amount do |order|
      number_to_currency(order.hst_amount)
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
      row :status
      row :subtotal_amount do |order|
        number_to_currency(order.subtotal_amount)
      end
      row :pst_amount do |order|
        number_to_currency(order.pst_amount)
      end
      row :gst_amount do |order|
        number_to_currency(order.gst_amount)
      end
      row :hst_amount do |order|
        number_to_currency(order.hst_amount)
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

  # Form configuration to manually change status
  form do |f|
    f.inputs "Order Details" do
      f.input :user
      f.input :status, as: :select, collection: ['new', 'paid', 'shipped']
      f.input :total_amount
    end
    f.actions
  end
end
