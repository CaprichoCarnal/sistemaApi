class CreateElaboratedProductMaterials < ActiveRecord::Migration[7.0]
  def change
    create_table :elaborated_product_materials do |t|
      t.references :elaborated_product, null: false, foreign_key: true
      t.references :supply, null: false, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end
