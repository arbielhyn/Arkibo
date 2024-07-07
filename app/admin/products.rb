# frozen_string_literal: true
ActiveAdmin.register Product do
  permit_params :name, :description, :price, :size, :category_id, images: []
  show do
    attributes_table do
      row :name
      row :description
      row :price
      row :size
      row :category
      row :created_at
      row :updated_at
      row "Images" do |product|
        if product.images.attached?
          product.images.each do |image|
            span image_tag(image.variant(resize: "300x300")), class: "admin-image-preview"
          end
        else
          span "No images attached", class: "admin-image-preview"
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
      f.input :images, as: :file, input_html: { multiple: true }
    end
    f.actions
  end
end
