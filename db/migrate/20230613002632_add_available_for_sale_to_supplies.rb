class AddAvailableForSaleToSupplies < ActiveRecord::Migration[7.0]
  def change
    add_column :supplies, :available_for_sale, :boolean
  end
end
