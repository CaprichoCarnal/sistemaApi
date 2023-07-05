class AddChannelNumberToRawMaterials < ActiveRecord::Migration[7.0]
  def change
    add_column :raw_materials, :channel_number, :string
  end
end
