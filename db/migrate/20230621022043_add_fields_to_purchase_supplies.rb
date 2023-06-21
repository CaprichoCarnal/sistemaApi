class AddFieldsToPurchaseSupplies < ActiveRecord::Migration[7.0]
  def change
    add_column :purchase_supplies, :weight, :decimal
    add_column :purchase_supplies, :raw_material, :boolean
  end
end
