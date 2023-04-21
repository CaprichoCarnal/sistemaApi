class CreateChannels < ActiveRecord::Migration[7.0]
  def change
    create_table :channels do |t|
      t.references :family, null: false, foreign_key: true
      t.references :supplier, null: false, foreign_key: true
      t.date :born_date
      t.string :born_in
      t.string :raised_in
      t.date :slaughter_date
      t.string :slaughtered_in
      t.string :crotal
      t.string :lot
      t.float :weight
      t.float :temperature
      t.string :classification
      t.boolean :available

      t.timestamps
    end
  end
end
