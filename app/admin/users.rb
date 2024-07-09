ActiveAdmin.register User do
  permit_params :username, :name, :email, :address, :province_id

  index do
    selectable_column
    id_column
    column :username
    column :name
    column :email
    column :address
    column :province_id
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
      f.input :address
      f.input :province_id, as: :select, collection: Province.all.map { |p| [p.name, p.id] }
    end
    f.actions
  end

end
