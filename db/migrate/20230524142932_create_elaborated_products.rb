class CreateElaboratedProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :elaborated_products do |t|
      t.string :name
      t.integer :weight
      t.string :lot
      t.string :description
      t.references :cut, null: false, foreign_key: true

      t.timestamps
    end
  end
end
