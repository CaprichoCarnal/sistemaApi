class CreateRawMaterialPurchases < ActiveRecord::Migration[7.0]
  def change
    create_table :raw_material_purchases do |t|
      t.date :date_of_purchase
      t.references :supplier, null: false, foreign_key: true
      t.string :invoice_code
      t.string :item
      t.references :family, null: false, foreign_key: true
      t.string :description
      t.string :lot
      t.integer :quantity
      t.integer :price
      t.integer :discount
      t.integer :total
      t.integer :vat
      t.string :status

      t.timestamps
    end
  end
end
