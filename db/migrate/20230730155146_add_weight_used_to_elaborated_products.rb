class AddWeightUsedToElaboratedProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :elaborated_products, :weight_used, :decimal
  end
end
