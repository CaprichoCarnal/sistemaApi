class AddTipoToRawMaterials < ActiveRecord::Migration[7.0]
  def change
    add_column :raw_materials, :type, :string
  end
end
