ActiveAdmin.register Page do
    permit_params :title, :content

    form do |f|
      f.inputs do
        f.input :title
        f.input :content, as: :ckeditor # if you have a rich text editor like CKEditor installed
      end
      f.actions
    end

    show do
      attributes_table do
        row :title
        row :content do |page|
          raw page.content # use `raw` if you want to render HTML content
        end
      end
    end
  end

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :title, :content
  #
  # or
  #
  # permit_params do
  #   permitted = [:title, :content]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
