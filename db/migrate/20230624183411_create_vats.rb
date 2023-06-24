class CreateVats < ActiveRecord::Migration[7.0]
  def change
    create_table :vats do |t|
      t.string :description
      t.integer :value

      t.timestamps
    end
  end
end
