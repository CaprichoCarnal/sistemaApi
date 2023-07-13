class AddWeightToSaleItems < ActiveRecord::Migration[7.0]
  def change
    add_column :sale_items, :weight, :decimal
  end
end
