class CreateCuts < ActiveRecord::Migration[7.0]
  def change
    create_table :cuts do |t|
      t.references :raw_material, null: false, foreign_key: true
      t.string :name
      t.string :lot
      t.float :weight
      t.boolean :matured
      t.date :maturity_start_date
      t.date :maturity_end_date
      t.boolean :frozen
      t.boolean :available_for_sale
      t.string :prepared_by

      t.timestamps
    end
  end
end
