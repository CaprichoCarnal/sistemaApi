class AddPaymentToRawMaterialPurchases < ActiveRecord::Migration[7.0]
  def change
    add_column :raw_material_purchases, :payment, :decimal
  end
end
