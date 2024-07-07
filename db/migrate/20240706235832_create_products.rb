class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.decimal :price
      t.string :size
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
