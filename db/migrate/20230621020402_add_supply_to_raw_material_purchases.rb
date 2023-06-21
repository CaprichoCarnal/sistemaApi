class AddSupplyToRawMaterialPurchases < ActiveRecord::Migration[7.0]
  def change
    add_column :raw_material_purchases, :supply, :boolean
  end
end
