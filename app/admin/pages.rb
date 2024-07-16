ActiveAdmin.register Page do
  permit_params :title, :content

  index do
    selectable_column
    column :id
    column :title
    column :content
    column :created_at
    column :updated_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :title
      f.input :content  # Assuming CKEditor is integrated
      # Use `:text` if CKEditor is not used
    end
    f.actions
  end

  show do
    attributes_table do
      row :title
      row :content do |page|
        raw page.content  # Render HTML content
      end
    end
  end
end
