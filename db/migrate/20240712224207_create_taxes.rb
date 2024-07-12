class CreateTaxes < ActiveRecord::Migration[7.1]
  def change
    create_table :taxes do |t|
      t.decimal :hst
      t.decimal :gst
      t.decimal :pst
      t.string :province

      t.timestamps
    end
  end
end
