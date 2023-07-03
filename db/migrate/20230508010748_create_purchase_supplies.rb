class CreatePurchaseSupplies < ActiveRecord::Migration[7.0]
  def change
    create_table :purchase_supplies do |t|
      t.string :date_of_purchase
      t.references :supplier, null: false, foreign_key: true
      t.string :invoice_code
      t.string :item
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
