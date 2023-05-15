class CreateElaboratedProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :elaborated_products do |t|
      t.string :name
      t.string :description
      t.string :lot
      t.string :prepared_by
      t.references :cut, null: false, foreign_key: true

      t.timestamps
    end
  end
end
