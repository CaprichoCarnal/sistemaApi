class CreateHistoricalElaborations < ActiveRecord::Migration[7.0]
  def change
    create_table :historical_elaborations do |t|
      t.date :date
      t.string :product_name
      t.string :ingredients
      t.string :lot_number
      t.string :final_lot_number
      t.string :final_weight

      t.timestamps
    end
  end
end
