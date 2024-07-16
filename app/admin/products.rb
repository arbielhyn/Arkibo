# frozen_string_literal: true
ActiveAdmin.register Product do
  permit_params :name, :description, :price, :size, :category_id, :on_sale, :image

  show do
    attributes_table_for(resource) do
      row :name
      row :description
      row :price
      row :size
      row :category
      row :created_at
      row :updated_at
      row :on_sale  # Add this row to display on_sale status
      row :image do |product|
        if product.image.attached?
          image_tag url_for(product.image), size: "200x200"
        else
          "No image available"
        end
      end
    end
  end

  index do
    selectable_column
    id_column
    column :name
    column :description
    column :price
    column :size
    column :category
    column :on_sale, &:on_sale  # Display on_sale status in the index
    column :created_at
    actions
  end

  filter :name
  filter :category
  filter :price
  filter :created_at

  form do |f|
    f.inputs do
      f.input :name
      f.input :description
      f.input :price
      f.input :size, as: :select, collection: ["Small", "Medium", "Large", "X-Large"]
      f.input :category_id, as: :select, collection: Category.pluck(:name, :id)
      f.input :on_sale, as: :boolean  # Add checkbox for on_sale status
      f.input :image, as: :file
    end
    f.actions
  end
end
