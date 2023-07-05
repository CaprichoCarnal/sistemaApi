class AddDecreaseToRawMaterials < ActiveRecord::Migration[7.0]
  def change
    add_column :raw_materials, :decrease, :decimal
  end
end
