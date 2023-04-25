class CreateProcessHistories < ActiveRecord::Migration[7.0]
  def change
    create_table :process_histories do |t|
      t.date :date
      t.string :material_name
      t.string :material_lot_number
      t.string :product_name
      t.string :product_lot_number

      t.timestamps
    end
  end
end
