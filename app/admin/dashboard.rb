ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    columns do
      column do
        panel "Quick Links" do
          ul do
            li link_to("Product Page", admin_products_path)
            li link_to("Contact Page", contact_path)
          end
        end
      end

      column do
        panel "Additional Info" do
          para "Some additional information here."
        end
      end
    end
  end
end
