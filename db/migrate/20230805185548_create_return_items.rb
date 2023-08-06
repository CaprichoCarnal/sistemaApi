class CreateReturnItems < ActiveRecord::Migration[7.0]
  def change
    create_table :return_items do |t|
      t.references :return, null: false, foreign_key: true
      t.references :sale_item, null: false, foreign_key: true
      t.integer :quantity_returned
      t.text :reason

      t.timestamps
    end
  end
end
