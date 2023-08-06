class CreateReturns < ActiveRecord::Migration[7.0]
  def change
    create_table :returns do |t|
      t.references :invoice, null: false, foreign_key: true
      t.text :reason

      t.timestamps
    end
  end
end
