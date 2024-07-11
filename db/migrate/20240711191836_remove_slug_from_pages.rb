class RemoveSlugFromPages < ActiveRecord::Migration[7.1]
  def change
    remove_column :pages, :slug, :string
    remove_index :pages, name: "index_pages_on_slug"
  end
end
