ActiveAdmin.register User do
  permit_params :username, :name, :email, :street, :city, :postal_code, :province

  index do
    selectable_column
    id_column
    column :username
    column :name
    column :email
    column :street
    column :city
    column :postal_code
    column :province
    column :created_at
    column :updated_at
    actions
  end

  filter :username
  filter :name
  filter :email
  filter :created_at

  form do |f|
    f.inputs do
      f.input :username
      f.input :name
      f.input :email
      f.input :street
      f.input :city
      f.input :postal_code
      f.input :province
    end
    f.actions
  end

end
