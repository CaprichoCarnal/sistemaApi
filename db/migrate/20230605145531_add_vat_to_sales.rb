class AddVatToSales < ActiveRecord::Migration[7.0]
  def change
    add_column :sales, :vat, :decimal
  end
end
