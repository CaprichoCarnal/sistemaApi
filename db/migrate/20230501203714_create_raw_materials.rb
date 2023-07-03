class CreateRawMaterials < ActiveRecord::Migration[7.0]
  def change
    create_table :raw_materials do |t|
      t.references :raw_material_purchase, null: false, foreign_key: true
      t.references :family, null: false, foreign_key: true
      t.references :supplier, null: false, foreign_key: true
      t.date :born_date
      t.string :born_in
      t.string :raised_in
      t.date :slaughter_date
      t.string :slaughtered_in
      t.string :crotal
      t.string :lot
      t.float :weight
      t.float :temperature
      t.string :classification
      t.string :available

      t.timestamps
    end
  end
end
