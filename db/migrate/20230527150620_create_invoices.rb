class CreateInvoices < ActiveRecord::Migration[7.0]
  def change
    create_table :invoices do |t|
      t.references :sale, null: false, foreign_key: true
      t.string :number
      t.date :date
      t.decimal :total

      t.timestamps
    end
  end
end
