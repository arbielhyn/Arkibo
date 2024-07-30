ActiveAdmin.register Tax do
  # Permitting the parameters for assignment
  permit_params :hst, :gst, :pst, :province

  # Optional: Customizing the index page
  index do
    selectable_column
    id_column
    column :hst
    column :gst
    column :pst
    column :province
    actions
  end

  # Optional: Customizing the form
  form do |f|
    f.inputs do
      f.input :hst
      f.input :gst
      f.input :pst
      f.input :province
    end
    f.actions
  end

  # Optional: Adding filters
  filter :hst
  filter :gst
  filter :pst
  filter :province
end
