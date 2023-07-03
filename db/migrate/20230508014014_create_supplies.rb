class CreateSupplies < ActiveRecord::Migration[7.0]
  def change
    create_table :supplies do |t|
      t.references :supplier, null: false, foreign_key: true
      t.string :lot
      t.string :name
      t.integer :quantity
      t.float :weight

      t.timestamps
    end
  end
end
