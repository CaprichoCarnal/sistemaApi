class CreateMixCuts < ActiveRecord::Migration[7.0]
  def change
    create_table :mix_cuts do |t|
      t.string :name
      t.integer :weight
      t.string :lot
      t.references :cut, null: false, foreign_key: true
      t.boolean :frozen
      t.date :expiration_date

      t.timestamps
    end
  end
end
