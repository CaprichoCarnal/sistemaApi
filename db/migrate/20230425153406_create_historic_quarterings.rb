class CreateHistoricQuarterings < ActiveRecord::Migration[7.0]
  def change
    create_table :historic_quarterings do |t|
      t.date :date
      t.string :id_channel
      t.string :piece_name
      t.string :lot
      t.string :operator_signature

      t.timestamps
    end
  end
end
