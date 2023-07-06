class AddProductSoldToSaleItems < ActiveRecord::Migration[7.0]
  def change
    add_column :sale_items, :product_sold, :string
  end
end
