class AddFinishedToCuts < ActiveRecord::Migration[7.0]
  def change
    add_column :cuts, :finished, :boolean
  end
end
