class RenameTypeColumnInRawMaterials < ActiveRecord::Migration[7.0]
  def change
    rename_column :raw_materials, :type, :material_type
  end
end
