class CreatePiecenames < ActiveRecord::Migration[7.0]
  def change
    create_table :piecenames do |t|
      t.references :family, null: false, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
