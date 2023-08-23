class AddPaymentToPurchaseSupplies < ActiveRecord::Migration[7.0]
  def change
    add_column :purchase_supplies, :payment, :decimal
  end
end
