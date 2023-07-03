class CreateSales < ActiveRecord::Migration[7.0]
  def change
    create_table :sales do |t|
      t.references :customer, null: false, foreign_key: true
      t.date :date
      t.decimal :total

      t.timestamps
    end
  end
end
