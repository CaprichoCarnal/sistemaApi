class AddAvailableWeightToRawMaterials < ActiveRecord::Migration[7.0]
  def change
    add_column :raw_materials, :available_weight, :decimal
  end
end
