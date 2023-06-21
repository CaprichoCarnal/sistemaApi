class AddExpirationDateToCuts < ActiveRecord::Migration[7.0]
  def change
    add_column :cuts, :expiration_date, :date
  end
end
