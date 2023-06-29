class AddDescriptionToRawMaterials < ActiveRecord::Migration[7.0]
  def change
    add_column :raw_materials, :description, :string
  end
end
