class AddPaymentToPurchaseSupplies < ActiveRecord::Migration[7.0]
  def change
    add_column :purchase_supplies, :payment, :decimal, default: 0
  end
end
