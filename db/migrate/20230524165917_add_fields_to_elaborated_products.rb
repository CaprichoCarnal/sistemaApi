class AddFieldsToElaboratedProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :elaborated_products, :frozen, :boolean
    add_column :elaborated_products, :expiration_date, :date
  end
end
