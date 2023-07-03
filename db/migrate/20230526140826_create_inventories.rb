class CreateInventories < ActiveRecord::Migration[7.0]
  def change
    create_table :inventories do |t|
      t.references :item, polymorphic: true, null: false
      t.string :category
      t.string :lot
      t.float :weight
      t.date :expiration_date

      t.timestamps
    end
  end
end
