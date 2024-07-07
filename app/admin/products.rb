ActiveAdmin.register Product do
  permit_params :name, :description, :price, :size, :category_id

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
      f.input :category
    end
    f.actions
  end
end
