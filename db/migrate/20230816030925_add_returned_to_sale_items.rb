class AddReturnedToSaleItems < ActiveRecord::Migration[7.0]
  def change
    add_column :sale_items, :returned, :boolean, default: false
  end
end
