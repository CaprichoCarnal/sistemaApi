class CreateMixedCuts < ActiveRecord::Migration[7.0]
  def change
    create_table :mixed_cuts do |t|
      t.references :mix_cut, null: false, foreign_key: true
      t.references :cut, null: false, foreign_key: true
      t.integer :weight

      t.timestamps
    end
  end
end
