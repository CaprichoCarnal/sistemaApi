class ChangeColumnNameInRawMaterialPurchases < ActiveRecord::Migration[7.0]
  def change
    rename_column :raw_material_purchases, :supply, :cut
  end
end
